class Public::ItemsController < ApplicationController
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def genre_search
    @genre = Genre.find(params[:id])
    @items = @genre.items.order(created_at: :DESC)
  end

  def index
    @items = Item.all
  end

  private

  def items_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_available)
  end

end
