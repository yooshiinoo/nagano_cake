class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @total = 0
    @customer = @order.customer
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.order_detail.update_all(status: 1) if @order.status == 1
      redirect_to admin_order_path(@order)
    end
  end

  def subtotal
    item.with_tax_price * amount
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
