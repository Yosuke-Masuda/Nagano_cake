class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses.order(created_at: :DESC)
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to request.referer, notice: "配送先を登録しました！"
    else
      @address_new = Address.new
      @addresses = current_customer.addresses
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: "配送先を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer, flash: {warning: "配達先を削除しました"}
  end

  private
    def address_params
      params.require(:address).permit(:postal_code, :address, :name, :customer_id)
    end
end
