class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @total = 0
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
       @order_details.update_all(making_status: 1) if @order.status == "payment_confirmation"
    end
    redirect_to admin_order_path(@order)
  end
  


  def subtotal
    item.with_tax_price * amount
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
