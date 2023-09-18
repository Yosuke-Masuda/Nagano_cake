class Item < ApplicationRecord
    
    attachment :image
    has_many :cart_items, dependent: :destroy
    has_many :order_details, dependent: :destroy
    has_many :orders, through: :order_details
    belongs_to :genre, class_name: 'Genre', foreign_key: 'genre_id'

    validates :name, presence: true
    validates :introduction, presence: true
    validates :price, presence: true
    validates :genre, presence: true
 
     def with_tax_price
      (price * 1.1).floor
     end
  
end
