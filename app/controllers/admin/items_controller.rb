class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!


   def index
     @items = Item.all.page(params[:page]).per(10)
   end

   def show
     @item = Item.find(params[:id])
   end

   def edit
     @item = Item.find(params[:id])
   end

   def update
     @item = Item.find(params[:id])
     if @item.update(item_params)
       flash[:notice] = "商品詳細変更が完了しました。"
       redirect_to admin_items_path(@item)
     else
       flash[:alert] = "商品詳細の変更内容に不備があります。"
       render :edit
     end
   end

   def new
     @item = Item.new
     @genres = Genre.all
   end

   def create
     @item = Item.new(item_params)
     if @item.save
       flash[:notice] = "商品の新規登録が完了しました。"
       @items = Item.all
       redirect_to admin_item_path(@item.id)
     else
       flash[:alert] = "商品の新規登録内容に不備があります。"
       render :new
     end
   end

   private
   def item_params
    params.require(:item).permit(:name, :image, :introduction, :genre_id, :price, :is_active)
   end
end
