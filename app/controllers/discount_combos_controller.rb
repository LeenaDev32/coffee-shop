class DiscountCombosController < ApplicationController

  def index
    @discount_combos = DiscountCombo.all
    render json: @discount_combos
  end

  def create
    combo = params[:combo].sort
    @discount_combo = DiscountCombo.create(combo: combo, discount: params[:discount])
    render json: @discount_combo
  end

end
