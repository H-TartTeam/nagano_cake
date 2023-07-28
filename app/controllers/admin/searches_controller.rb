class Admin::SearchesController < ApplicationController

  def search
    #検索した名前をViewで表示させるための変数
    @word = (params[:q][:name_cont])
    @q = Item.ransack(params[:q])
    @item = @q.result#(distinct: true)
    #@result = params[:q]&.values&.reject(&:blank?)
  end

end
