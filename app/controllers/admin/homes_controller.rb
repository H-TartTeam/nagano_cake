class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @order = Order.new
  end

end
