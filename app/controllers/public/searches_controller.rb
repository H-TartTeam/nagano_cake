class Public::SearchesController < ApplicationController

  def search
    @word = (params[:post][:search])
    @q = Item.ransack(params[:q])
    @item = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end

end
