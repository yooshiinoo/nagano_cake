class Public::ItemsController < ApplicationController
  def index
    @guides = Genre.all
    @total_items = Item.all
    @items = Item.all.page(params[:page])
  end

  def show
    @guides = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_item_path(@item)
  end


  def with_tax_price
    (price * 1.1).floor
  end

  private
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end



end
