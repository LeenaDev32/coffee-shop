class OrdersController < ApplicationController
    before_action :select_order, :calculated_amount, :calculated_discount, only: [:update]

    def index
      @orders = current_user.orders.all

      render json: @orders
    end

    def update
      @order.update(total: @total_price, discount: @discount, user_id: current_user.id, status: orders_parameters[:status])

      render json: @order
    end

    private

    def select_order
      @order = Order.find(params[:id]) || Order.find_or_create_by(status: "pending", user_id: current_user.id)
    end

    def calculated_amount
      @price = 0
      @order&.items.each do |item|
        @price += item.product.price * item.quantity + item.product&.tax
      end
    end

    def calculated_discount
      ids = @order.items.pluck(:product_id).sort
      discount_combo = DiscountCombo.find_by(combo: ids)
      @discount = discount_combo.present? ? @price*discount_combo.discount/100 : 0
      @total_price = @price - @discount if @price
    end

    def orders_parameters
      params.require(:order).permit(
        :status
      )
    end
end

