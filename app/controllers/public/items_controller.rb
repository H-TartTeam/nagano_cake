class Public::ItemsController < ApplicationController
  def show
  end

  def index
  @Item = Item.find(params[:id])
  @cart_item = CartItem.new
  end
end
