class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  # 注文情報入力画面を表示するアクション
  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      # カートが空でない場合、新しい注文オブジェクトを生成
      @order = Order.new
      # 登録済みの配送先情報を取得し、フォームで選択するためのオブジェクトに割り当て
      @shipping_address = ShoppingAddress.all
    else
      # カートが空の場合、エラーメッセージを表示して前のページにリダイレクト
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end

  # 注文情報確認画面を表示するアクション
  def confirm
    if params[:order]
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @cart_items = current_customer.cart_items
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @order.postage = 800
      @order_total_amount = @total_amount + @order.postage.to_i

      if params[:order][:select_address] == "0"
        @order.shipping_post_code = current_customer.post_code
        @order.shipping_address = current_customer.address
        @order.shipping_name = current_customer.last_name + current_customer.first_name
      elsif params[:order][:select_address] == "1"
        if ShippingAddress.exists?(id: params[:order][:address_id])
          @address = ShippingAddress.find(params[:order][:address_id])
          @order.shipping_name = @address.name
          @order.shipping_post_code = @address.postal_code
          @order.shipping_address = @address.address
        else
          # 配送先情報が見つからない場合、エラーメッセージを表示して注文情報入力画面を再表示
          flash[:notice] = "配送先情報がありません"
          render 'new'
        end
      elsif params[:order][:select_address] == "2"
        @order.shipping_name = params[:order][:shipping_name]
        @order.shipping_post_code = params[:order][:shipping_post_code]
        @order.shipping_address = params[:order][:shipping_address]
      else
        # フォームの入力が不正な場合、注文情報入力画面を再表示
        render 'new'
      end
      # セッションに注文情報を保存
      session[:order] = @order.attributes
    end

    # セッションから注文情報を取得し、確認画面に表示するための情報を取得
    if session[:order]
      @order = Order.new(session[:order])
      @cart_items = current_customer.cart_items
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      @order.postage = 800
      @order_total_amount = @total_amount + @order.postage.to_i
      @address = "〒" + @order.shipping_post_code + @order.shipping_address
    else
      @order = Order.new
    end
  end

  # 注文を作成するアクション
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @cart_items = current_customer.cart_items
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.postage = 800
    @order.billing_amount = @total_amount + @order.postage.to_i

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
    params.require(:order).permit(:customer_id, :postage, :billing_amount, :status, :payment_method, :shipping_name, :shipping_post_code, :shipping_address)
  end
end
