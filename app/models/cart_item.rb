class CartItem < ApplicationRecord
   belongs_to :customer
   belongs_to :item


   validates :amount, numericality:{ only_integer: true }, presence: true
   
   def with_tax_price
    (price * 1.1).floor
   end

   def subtotal
    item.with_tax_price * amount
   end



end
