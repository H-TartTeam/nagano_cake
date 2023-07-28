class ApplicationController < ActionController::Base

  before_action :search_box_setup

  def search_box_setup
    @q = Item.ransack(params[:q])
    @item = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end

end