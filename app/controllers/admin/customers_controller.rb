class Admin::CustomersController < ApplicationController
  module Admin
    def index
      @customers = Customers.all
    end

    def show
    end

    def edit
    end
  end
end
