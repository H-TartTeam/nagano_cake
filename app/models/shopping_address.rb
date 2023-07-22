class ShoppingAddress < ApplicationRecord

  belongs_to :customer

  def shopping_address_all
     self.postcode + self.address + self.name
  end

end
