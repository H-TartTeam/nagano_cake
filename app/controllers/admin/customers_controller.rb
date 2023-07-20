class Admin::CustomersController < ApplicationController
  module Admin
    def index
      #.page(params[:page])ページネーション
      @customers = Customers.all.page(params[:page])
    end

    def show
    end

    def edit
    end
  end
end
