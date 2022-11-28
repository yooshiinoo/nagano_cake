class Admin::OrdersDetailsController < ApplicationController

  def update
    @order_detail = Order_detail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_path(@order)
    end
  end


  def subtotal
    item.with_tax_price * amount
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :amount, :making_status)
  end

end
