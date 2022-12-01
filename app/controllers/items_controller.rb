class ItemsController < ApplicationController
  before_action :set_order, only: [:create]
  after_action :calculate_amount_discount, only: [:create]

  def index
    @items = current_user.items&.all

    render json: @items
  end

  def create
    item = Item.new(user_id: current_user.id, order_id: @order.id, product_id: params[:product_id], quantity: params[:quantity])

    if item.save!
      render json: item
    else
      render json: { error: 'items not created' }
    end
  end

  private

  def set_order
    @order = Order.find_or_create_by(status: "pending", user_id: current_user.id)
  end

  def calculate_amount_discount
    price = 0
    @order.items.each do |item|
      price += item.product&.price * item.quantity + item.product&.tax
    end
    discount = 0
    total_price = price - discount if price
    @order.update(total: total_price || price, discount: discount || 0)
  end
end
