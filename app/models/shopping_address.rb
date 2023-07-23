class ShoppingAddress < ApplicationRecord

  def shopping_address_all
     self.postcode + self.address + self.name
  end

  belongs_to :order, optional: true
  belongs_to :customer

end
