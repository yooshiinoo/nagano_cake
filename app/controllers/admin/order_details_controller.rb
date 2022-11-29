class Admin::OrdersDetailsController < ApplicationController

  def update
    @order = Order.find(params[:order_id])
    @order_detail = Order_detail.find(params[:id])
    @order_details = @order.order_details.all

    is_updated = true
    if @order_detail.update(order_detail_params)
      @order.update(status: 2) if @order_detail.making_status == "in_production"
      @order_details.each do |order_detail|
        if order_detail.making_status != "production_complete"
          is_updated = false
        end
      end
      @order.update(status: 3) if is_updated
    end
    redirect_to admin_order_path(@order)
  end


  def subtotal
    item.with_tax_price * amount
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :amount, :making_status)
  end

end
