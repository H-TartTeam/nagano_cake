class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy

  #税込計算
  def taxin_price
    price*1.1
  end

end
