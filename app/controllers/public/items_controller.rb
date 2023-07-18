class Public::ItemsController < ApplicationController
  def show
  @Item = Item.find(params[:id])
  @cart_item = CartItem.new
  end

  def index
  end
end
