class Public::OrdersController < ApplicationController

  def new
    # カートに商品が入っているかを確認
    cart_items = current_customer.cart_items
    if cart_items.present?
      # カートが空でない場合、新しい注文オブジェクトを生成
      @order = Order.new
      # 新しいお届け先のフォームに使う、新しい住所オブジェクトを生成
      @new_address = ShoppingAddress.new
      # 登録済みのお届け先の一覧を取得し、フォームで選択するためのオブジェクトに割り当て
      @registered_addresses = current_customer.shopping_addresses
    else
      # カートが空の場合、エラーメッセージを表示して前のページにリダイレクト
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end
  # 他のアクションの定義...
end