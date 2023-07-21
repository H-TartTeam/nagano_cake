class Admin::CustomersController < ApplicationController
  def index
    #customer = Customer.find(params[:id])
    #page(params[:page])ページネーション
    @customers = Customer.all.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報が更新されました。"
      redirect_to admin_customer_path(@customer)
    else
      render 'edit'
    end
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_kana_name, :last_kana_name, :email, :address, :phone_number, :is_deleted)
  end

end
