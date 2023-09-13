class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!



  def update
    @order_detail = OrderDetail.find(params[:id])

    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    #制作ステータスを「制作中（２）」→注文ステータスを「制作中（２）」
    if @order_detail.making_status == "製作中"
      @order.update(status: 2)
      flash[:notice] = "制作ステータスの更新しました。"
      @order.save
    end

    #注文個数と制作完了になっている個数が同じなら
    if @order.order_details.count == @order.order_details.where(making_status: 3).count
      @order.update(status: 3)
      #flash[:notice] = "制作ステータスの更新をしました。"
      @order.save
    end

    redirect_to admin_order_path(params[:order_id])
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :amount, :making_status, :price)
  end

end
