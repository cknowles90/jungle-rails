class LineItem < ApplicationRecord

  belongs_to :order
  belongs_to :product

  monetize :item_price_cents, numericality: true
  monetize :total_price_cents, numericality: true

  def total 
    quantity * (item_price_cents / 100.0)
  end
end
