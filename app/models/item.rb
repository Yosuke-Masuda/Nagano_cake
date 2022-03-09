class Item < ApplicationRecord
    belongs_to :genre
    has_many :order_details, dependent: :destroy
    has_many :orders, through: :order_details
    
    attachment :image
    
    validates :genre_id, :name, :price, :introduction, presence: true
    validates :image, presence: true
end
