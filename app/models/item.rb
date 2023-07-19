class Item < ApplicationRecord
  
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre
  has_many :orders, through: :order_items

  
  attachment :image
  
  with_options presence: true do
    validates :name, presence: true
    validates :description, presence: true
    validates :genre, presence: true
    validates :price,presence: true, numericality: { only_integer: true, greater_than: 0}
    validates :image
  end
end