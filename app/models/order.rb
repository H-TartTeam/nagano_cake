class Order < ApplicationRecord

#credit_card: = key   0, = value(値)
  enum payment_method: { credit_card: 0, transfer: 1 }

  has_one :shopping_address
end
