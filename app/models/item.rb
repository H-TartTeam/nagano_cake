class Item < ApplicationRecord

  enum status: {
    販売中: true,
    売り切れ: false
  }

  #税込計算
 def taxin_price
  price*1.1
 end

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre
  has_many :orders, through: :order_items

  has_one_attached :image

  with_options presence: true do
    validates :name, presence: true
    validates :introduction, presence: true
    validates :is_available, presence: true
    validates :price,presence: true, numericality: { only_integer: true, greater_than: 0}
    validates :image
  end
end
