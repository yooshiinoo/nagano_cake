class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.all
    @addresses = current_customer.addresses
    @address = current_customer.address
  end

  def confirm
    @cart_item = current_customer.cart_item
    @total = 0
    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

  end

  def complete
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def create
  end



  def total_payment
    @total + @order.shipping_cost
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
