class Public::OrdersController < ApplicationController
  def new
  end

  def index
  end

  def show
  end

  def complete
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
