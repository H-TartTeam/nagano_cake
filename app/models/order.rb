class Order < ApplicationRecord

  #credit_card: = key   0, = value(値)
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }

  has_one :shopping_address
end
