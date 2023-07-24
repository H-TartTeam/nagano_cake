class ApplicationController < ActionController::Base
#before_action :configure_permitted_parameters, if: :devise_controller? 必要ないかも

  before_action :search

  def search
    @q = Item.ransack(params[:q])
    @item = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end

end