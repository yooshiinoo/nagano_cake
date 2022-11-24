class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
    @address = current_customer.address
  end

  def confirm
    @cart_items = current_customer.cart_items
    @total = 0
    @order = Order.new(
      customer: current_customer,
      payment_method: params[:order][:payment_method])

    if params[:order][:select_address] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.full_name

    elsif params[:order][:select_address] == "2"
      ship = Address.find(params[:order][:address_id])
      @order.postal_code = ship.postal_code
      @order.address = ship.address
      @order.name = ship.name

    elsif params[:order][:select_address] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
      @ship = "1"

      unless @order.valid? == true
        @addresses = Address.where(customer: current_customer)
        render :new
      end
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save

    if params[:order][:ship] == "1"
      current_customer.address.create(address_params)
    end

    @cart_item = current_customer.cart_item
    @cart_item.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.amount = cart_item.amount
      @order_detail.price = @order.with_tax_price
      @order_detail.save
    end

    @cart_items.destroy_all
    redirect_to public_orders_complete_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @total = @Orders.order_detail.subtotal
    @order_details = @Order.order_details
  end


  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end


  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end

end
