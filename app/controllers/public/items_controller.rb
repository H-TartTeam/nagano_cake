class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def index
    @items_all = Item.all
  end
end
