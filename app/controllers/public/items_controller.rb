class Public::ItemsController < ApplicationController

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def index
    @items = Item.all
  end

  private

  def items_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_available)
  end

end
