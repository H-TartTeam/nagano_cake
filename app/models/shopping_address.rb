class ShoppingAddress < ApplicationRecord

  belongs_to :order, optional: true
  belongs_to :customer

end
