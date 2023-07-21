class Public::OrdersController < ApplicationController

  def new
    cart_items = current_customer.cart_items
    if cart_items.present?
      @order = Order.new
      @new_address = ShoppingAddress.new
      @registered_addresses = current_customer.shopping_addresses
    else
      flash[:notice] = "カートが空です"
      redirect_to request.referer
    end
  end

  # 他のアクションの定義...
end