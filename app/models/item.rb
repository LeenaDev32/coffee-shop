class Item < ApplicationRecord
  belongs_to :user
  belongs_to :order
  belongs_to :product
  validates :user_id, :order_id, :product_id, presence: true
end
