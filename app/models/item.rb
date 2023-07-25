class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_item
  belongs_to :genre

  enum status: {
    販売中: true,
    売り切れ: false
  }

  # カート内の数量を取得するメソッド
  def cart_item_quantity(customer)
    cart_item = customer.cart_items.find_by(item_id: self.id)
    cart_item ? cart_item.quantity : 0
  end

  # 税込価格を計算するメソッド
  def taxin_price
    (price * BigDecimal('1.1')).to_i
  end

  # 税込価格から数量を計算して小計をだすメソッド
  def subtotal
    (item.taxin_price * quantity.to_i).to_i
  end

  has_one_attached :image

  def get_item_image
    #すり抜け防止
    (image.attached?) ? image : 'brownie.jpg'
  end

  with_options presence: true do
    validates :name, presence: true
    validates :introduction, presence: true
    validates :is_available, presence: true
    validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
    # validates :image
  end
  
end