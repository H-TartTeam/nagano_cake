class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_product, only: %i[show edit update]

    def index
      @items = Item.all
    end

    def new
      @item = Item.new
    end

    def create
      @item =Item.new(item_params)
      @item.status = true
      
    if @item.save
       redirect_to admin_item_path(@item), notice: "商品が登録されました☺︎"
    else
      render :new, notice: "商品の登録︎が失敗しました"
    end
    end
    
    def show
    @item = Item.find(params[:id]) 
    @item_images = @item.item_images
    end
    
    def edit
    @item = Item.find(params[:id])
    end
    
    def update
       @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to admin_item_path(@item)
      else
      render :edit
      end
    end
    
    def search
    end
    
    private
    
    def item_params
      params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_available)
    end

    def set_product
    end
  end