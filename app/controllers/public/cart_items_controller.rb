class Public::CartItemsController < ApplicationController
  def index
    @cart_item = Cart_item.new
    
  end
  
  def create
    @cart_item = Cart_item.new(cart_item_params)
    if @cart_item.save
      redirect_to public_cart_items_path(@cart_item)
    else
      @cart_item = Cart_item.new
      render :index
    end
  end
  
  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :customer_id, :amount)
  end
  
end
cart_item_params[:item_id]