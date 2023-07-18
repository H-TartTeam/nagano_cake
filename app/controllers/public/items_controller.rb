class Public::ItemsController < ApplicationController
  def show
  #商品をカートに入れられるようにする
  @Item = Item.find(params[:id])
  @cart_item = CartItem.new
  end

  def index
  end
end
