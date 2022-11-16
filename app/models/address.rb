class Address < ApplicationRecord
  belongs_to :customer

  def full_address
    postal_code + address + name
  end

  def order_address
    self.postal_code + self.address + self.name
  end

end
