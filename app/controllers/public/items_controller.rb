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
    # パラメーターから検索クエリを取得します
    @query = params[:item]
    # もしクエリが指定されている場合
    if @query.present?
      # 商品を検索します（例: 商品名と説明文の部分一致検索）
      @items = Item.where("name LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")
    else
      # クエリが指定されていない場合は全ての商品を表示します
      @items = Item.all
    end
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
