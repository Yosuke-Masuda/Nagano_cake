class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :orders, dependent: :destroy

  validates :last_name, :first_name, :kana_last_name, :kana_first_name,
            :address, :phone_number, 
            presence: true
  validates :postal_code, length: { is: 7 }, numericality: { only_integer: true }
  validates :kana_last_name, :kana_first_name, 
            presence: true
end
