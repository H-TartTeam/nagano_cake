class Public::CustomersController < ApplicationController

   #before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end


  def update
    @customer = current_customer
    if current_customer.update(customer_params)
      redirect_to customers_mypage_path(@customer)
    else
      render "edit"
    end
  end

end


private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_kana_name, :first_kana_name, :postcode, :address, :phone_number, :email)
  end




