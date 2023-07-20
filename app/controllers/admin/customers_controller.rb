class Admin::CustomersController < ApplicationController
  def index
    #@customer = Customer.find(params[:id])
    #page(params[:page])ページネーション
    @customers = Customer.all.page(params[:page])
  end

  def show
  end

  def edit
  end

end
