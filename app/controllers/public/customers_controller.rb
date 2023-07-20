class Public::CustomersController < ApplicationController

   #before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer.params)
    redirect_to edit_customer_path(@customer)

  end




end






