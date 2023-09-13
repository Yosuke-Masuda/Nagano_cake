class Public::OrdersController < ApplicationController
    def index
        #最新の注文から並べるために.reverse_orderを使用している
        @orders = current_customer.orders.page(params[:page]).per(8).reverse_order
    end


    def complete
    end

    def new
        @cart_items = current_customer.cart_items
        if @cart_items.blank?
          redirect_to root_path
        end
        @order = Order.new
        @address = current_customer.address
        @address_new = Address.new
        @addresses = current_customer.addresses
    end


    #newページから情報を取得して、confirmページ上に情報を書き出すための記述
    def confirm
        @cart_items = current_customer.cart_items
        @order = Order.new(order_params)
        @order.shipping_cost = 800
        @order.payment_method = params[:order][:payment_method]

        #ラジオボタンで選択した時の取得する情報の条件分岐、enumではなくnew.html.erbで0,1,2を振り分けている
        if params[:order][:address_num] == "0"
            @order.postal_code = current_customer.postal_code
            @order.address = current_customer.address
            @order.name = current_customer.last_name + current_customer.first_name
        elsif params[:order][:address_num] == "1"
            #f.selectのaddress_boxの中の/:id の番号を取得する
            @address = Address.find(params[:order][:address_box])
            @order.postal_code = @address.postal_code
            @order.address = @address.address
            @order.name = @address.name

        elsif params[:order][:address_num] == "2"
            @order.postal_code = params[:order][:postal_code]
            @order.address = params[:order][:address]
            @order.name = params[:order][:name]
        end

    end

    def show
        @order = Order.find(params[:id])
        @order_details = @order.order_details
    end

    #confirmページで注文を確定するを押した後の動作を記述してる
    def create
        #order_paramsで取得できる情報の保存
        order = Order.new(order_params)
        order.status = 0
        order.customer_id = current_customer.id
        order.save

        #商品情報の保存
        cart_items = current_customer.cart_items
        cart_items.each do |cart_item|
            order_detail = OrderDetail.new
            order_detail.order_id = order.id
            order_detail.item_id = cart_item.item.id
            order_detail.amount = cart_item.amount
            order_detail.price = cart_item.subtotal
            order_detail.save
        end

        current_customer.cart_items.destroy_all


        unless Customer.where(id: order.customer_id).where(postal_code: order.postal_code).where(address: order.address) || Address.where(customer_id: order.customer_id).where(name: order.name).where(postal_code: order.postal_code).where(address: order.address).exits?
            address = Address.new
            address.customer_id = order.customer_id
            address.name = order.name
            address.postal_code = order.postal_code
            address.address = order.address
            address.save
        end
        redirect_to complete_orders_path
    end

    private

    def order_params
        params.require(:order).permit(:payment_method, :postal_code, :address, :name, :total_payment, :shipping_cost, :status, :customer_id)
    end
end
