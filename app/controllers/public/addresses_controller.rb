class Public::AddressesController < ApplicationController
  
  before_action :authenticate_customer!

  def index
    @shopping_addresses = current_customer.shopping_addresses
    @shopping_address_new = ShoppingAddress.new
  end

  def create
    shopping_address = ShoppingAddress.new(shopping_address_params)
    shopping_address.customer_id = current_customer.id
    if shopping_address.save
      redirect_to addresses_path, notice: "新しい配送先が登録されました"
    else
      redirect_to addresses_path, alert: "配送先の登録に失敗しました"
    end
  end

  def edit
    @shopping_address = ShoppingAddress.find(params[:id])
  end

  def update
    @shopping_address = ShoppingAddress.find(params[:id])
    if @shopping_address.update(shopping_address_params)
       redirect_to addresses_path, notice: "配送先の編集が完了しました"
    else
       redirect_to edit_address_path, alert: "配送先の編集に失敗しました"
    end
  end

  def destroy
    @shopping_address = ShoppingAddress.find(params[:id])
    @shopping_address.destroy
    redirect_to addresses_path
  end

  private

  def shopping_address_params
    params.require(:shopping_address).permit(:address, :name, :postcode)
  end


end