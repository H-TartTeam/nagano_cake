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
      if @item.save
        redirect_to admin_item_path(@item)
      else
      render :new
      end
    end
    
    def show
    @item = item.find(params[:id])  
    end
    
    def edit
    @item = item.find(params[:id])
    end
    
    def updaete
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
      params.require(:item).item(:image, :name, :introduction, :genre, :price, :is_available)
    end

end