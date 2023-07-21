class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy

  def full_name
    "#{last_name} #{first_name}"
  end

  #制限をかけるためにはバリデーションが必要
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_kana_name, presence: true
  validates :first_kana_name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :is_deleted, inclusion: { in: [true, false] }

end
