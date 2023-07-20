class Admin::CustomersController < ApplicationController
  module Admin
    def index
      @customer = Customer.find(params[:id])
      #.page(params[:page])ページネーション
      @customers = Customers.all.page(params[:page])
    end

    def show
    end

    def edit
    end

  end
end
