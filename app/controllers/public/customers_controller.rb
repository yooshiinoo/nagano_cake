class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.all
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to public_customer_path(current_customer)
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end

end
