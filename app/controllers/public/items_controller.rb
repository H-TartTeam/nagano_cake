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

  def search
    @keyword = params[:name][:search] if params[:name]
    @item_all = Item.search(@keyword)
    @item = Kaminari.paginate_array(@item_all).page(params[:page]).per(10)
    render :search
  end

  def show_search_results
    @keyword = params[:search]
    @item_all = Item.where(['content LIKE(?) OR title LIKE(?)', "%#{@keyword}%", "%#{@keyword}%"])
    @item = Kaminari.paginate_array(@item_all).page(params[:page]).per(10)
    render :search
  end

  private

  def items_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :is_available)
  end

end
