class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  # 注文情報入力画面を表示するアクション
  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      # カートが空でない場合、新しい注文オブジェクトを生成
      @order = Order.new
      # 登録済みの配送先情報を取得し、フォームで選択するためのオブジェクトに割り当て
      @shopping_address = ShoppingAddress.all
    else
      # カートが空の場合、エラーメッセージを表示して前のページにリダイレクト
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end

  # 注文情報確認画面を表示するアクション
  def confirm
    #注文情報入力されたデータが入って本当に存在するかどうか判断
    if params[:order]
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @cart_items = current_customer.cart_items
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @order.postage = 800
      @order.total_amount = @total_amount + @order.postage.to_i

      #配送先データが格納されて (ラジオボタンのenumの数字)
      if params[:order][:select_address] == "0"
        #自分の住所に配送を選んだ場合
        @order.postcode = current_customer.postcode
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name
      #登録した配送先を選んだ場合
      elsif params[:order][:select_address] == "1"
        #本当に登録されている配送先かどうか判断
        if ShoppingAddress.exists?(id: params[:order][:address_id])
          @address = ShoppingAddress.find(params[:order][:address_id])
          @order.name = @address.name
          @order.postcode = @address.postal_code
          @order.address = @address.address
        else
          # 配送先情報が見つからない場合、エラーメッセージを表示して注文情報入力画面を再表示
          flash[:notice] = "配送先情報がありません"
          render 'new'
        end
      #新しい配送先を選んだ場合
      elsif params[:order][:select_address] == "2"
        @order.name = params[:order][:name]
        @order.postcode = params[:order][:postcode]
        @order.address = params[:order][:address]
      else
        # フォームの入力が不正な場合、注文情報入力画面を再表示
        render 'new'
      end
    end
  end

  # 注文を作成するアクション
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.total_amount = @total_amount + @order.postage.to_i

    if @order.save
      # 注文が保存された場合、注文商品情報も保存する
      current_customer.cart_items.each do |cart_item|
        @order_item = OrderItem.new
        @order_item.item_id = cart_item.item_id
        @order_item.order_id = @order.id
        @order_item.price_including_tax = cart_item.item_with_tax_price
        @order_item.quantity = cart_item.quantity
        @order_item.production_status = 0
        @order_item.save
      end
      # 注文が完了したらカートを空にして、注文完了画面にリダイレクトする
      current_customer.cart_items.destroy_all
      redirect_to completed_orders_path
    else
      # 注文情報が不正な場合、エラーメッセージを表示して注文情報入力画面を再表示
      flash[:notice] = "住所は必須です"
      @order = Order.new(order_params)
      render 'new'
    end
  end

  # 注文完了画面を表示するアクション
  def completed
  end

  # 注文履歴一覧を表示するアクション
  def index
    @orders = current_customer.orders.all.page(params[:page]).per(5).order(created_at: :DESC)
  end

  # 注文詳細画面を表示するアクション
  def show
    @order = current_customer.orders.find(params[:id])
    @order_items = @order.order_items.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_amount, :status, :payment_method, :name, :postcode, :address)
  end
end
