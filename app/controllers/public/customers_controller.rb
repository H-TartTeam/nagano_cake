class Public::CustomersController < ApplicationController

   #before_action :authenticate_customer!

  def show
    @customer = Customer.find_by(id: params[:id])
  end



end






