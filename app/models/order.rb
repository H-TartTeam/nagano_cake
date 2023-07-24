class Order < ApplicationRecord

  #credit_card: = key   0, = value(値)
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_for_payment: 0, confirmation_of_payment: 1, in_production: 2, preparing_to_ship: 3, shipped: 4  }

  has_one :shopping_address
  has_many :order_items

  #名前を氏＋名を合わせて氏名で表示できるようにした
  def full_name
    "#{last_name} #{first_name}"
  end

end
