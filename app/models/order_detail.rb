class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { "着手不可": 0, "制作待ち": 1, "制作中": 2, "制作完了": 3, "発送済み": 4 }

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end

end
