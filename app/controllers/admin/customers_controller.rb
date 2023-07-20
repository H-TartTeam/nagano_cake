class Admin::CustomersController < ApplicationController
  def index
    @customers = Customers.all
  end

  def show
  end

  def edit
  end
end
