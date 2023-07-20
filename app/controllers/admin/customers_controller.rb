class Admin::CustomersController < ApplicationController
  def index
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
  end

  private

  def user_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_kana_name, :first_kana_name, :is_deleted, :address, :postcode, :phone_number)
  end

end
