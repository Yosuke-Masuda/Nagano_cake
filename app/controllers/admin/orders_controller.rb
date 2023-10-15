class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      if @order.status == "入金確認"
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: 1)
       end
      end
    end

  flash[:notice] = "注文ステータスを変更しました。"
   redirect_to admin_order_path(@order)
  end
  private

  def order_params
    params.require(:order).permit(:status)
  end




end
