class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    if params[:customers_id]
      #遷移してきたIDをwhereで取得
      @orders = order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
    else
      #オーダーデータ全て
      @orders = Order.all.page(params[:page]).per(10).order(created_at: :desc)
    end
  end
end
