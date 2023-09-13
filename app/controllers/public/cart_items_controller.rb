class Public::CartItemsController < ApplicationController
  def create
  @cart_item = CartItem.new(params_cart_item)
  @cart_item.customer_id=current_customer.id
  @cart_items=current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if cart_item.item_id==@cart_item.item_id
      new_amount = cart_item.amount + @cart_item.amount
      cart_item.update_attribute(:amount, new_amount)
      @cart_item.delete
      end
    end

    @cart_item.save
    redirect_to cart_items_path, notice:"カートに商品が入りました"
  end


  def index
   @cart_items= current_customer.cart_items.all
   @cart_item=CartItem.new

  end



  def update
    @cart_item = CartItem.find(params[:id])
      if @cart_item.update(params_cart_item)

        flash[:notice] = "カート内商品の個数を更新しました"
      else
        flash[:alert] = 'カート内商品の更新に失敗しました'
      end
      redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items=current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path, flash: {warning: "カート内商品ををすべて削除しました"}
  end



  private

    def params_cart_item
      params.require(:cart_item).permit(:amount, :item_id)
    end
end
