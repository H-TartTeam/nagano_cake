class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  #model/の税込価格から数量を計算して小計をだすメソッド
  def subtotal
    item.subtotal * quantity
  end

end
