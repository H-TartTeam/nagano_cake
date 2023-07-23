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
      #データが入る空の変数作成
      @order = Order.new(order_params)
      #ログインしているcustomerデータが入る
      @order.customer_id = current_customer.id
      #ログインしているcart_itemsデータが入る
      @cart_items = current_customer.cart_items
      #カート内商品の合計金額を算出して入れる
      @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
      #送料を入れる
      @order.postage = 800
      #合計金額と送料を+して請求金額を算出して入れる
      @order.total_amount = @total_amount + @order.postage.to_i

      #配送先データが格納されて (ラジオボタンのenumの数字)
         #自分の住所に配送を選んだ場合
      if params[:order][:select_address] == "0"
        #ログインしているユーザー自身の郵便番号が入る
        @order.postcode = current_customer.postcode
        #ログインしているユーザー自身の住所が入る
        @order.address = current_customer.address
        #ログインしているユーザーの氏と名が入る
        @order.name = current_customer.last_name + current_customer.first_name
            #登録した配送先を選んだ場合
      elsif params[:order][:select_address] == "1"
        #本当に登録されている配送先かどうか判断
        if params[:order][:address_id]
          #注文情報入力で選ばれた配送先のIDを入れている
          @address = ShoppingAddress.find(params[:order][:address_id])
          #IDから名前を取り出して入れる
          @order.name = @address.name
          #IDから郵便番号を取り出して入れる
          @order.postcode = @address.postalcode
          #IDkら住所を取り出して入れる
          @order.address = @address.address
        else
          # 配送先情報が見つからない場合、エラーメッセージを表示して注文情報入力画面を再表示
          flash[:notice] = "配送先情報がありません"
          render 'new'
        end
      #新しい配送先を選んだ場合
      elsif params[:order][:select_address] == "2"
        #注文情報入力画面のフォームに記述された名前データを入れる
        @order.name = params[:order][:name]
        #上記と同じデータは郵便番号
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
    #ログインしているユーザーのcustomerデータを変数に入れる
    @order.customer_id = current_customer.id
    #ログインしているユーザーのあcart_itemsデータを変数に入れる
    @cart_items = current_customer.cart_items
    #カート内商品を受け取って合計金額を算出
    @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    #送料
    @order.postage = 800
    #送料と合計金額を＋して請求金額を算出
    @order.total_amount = @total_amount + @order.postage.to_i

    if @order.save
      # 注文が保存された場合、注文商品情報も保存する
      current_customer.cart_items.each do |cart_item|
        @order_item = OrderItem.new
        #cart_itemデータの中にあるitem_idを取り出して変数に格納
        @order_item.item_id = cart_item.item_id
        #注文確定されたデータを格納
        @order_item.order_id = @order.id
        #税抜価格データを格納
        @order_item.price = cart_item.item.price
        #注文確定された数量データを格納
        @order_item.quantity = cart_item.quantity
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
  end

  # 注文詳細画面を表示するアクション
  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postage, :total_amount, :status, :payment_method, :name, :postcode, :address)
  end
end
