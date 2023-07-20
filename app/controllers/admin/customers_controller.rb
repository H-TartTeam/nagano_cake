class Admin::CustomersController < ApplicationController

  def new

  end

  def create

  end

  def index
    @customer = Customer.find(params[:id])
  end

  def show

  end

  def edit
  end
end
