class CreateDiscountCombos < ActiveRecord::Migration[6.1]
  def change
    create_table :discount_combos do |t|
      t.string :combo, array: true, default: []
      t.float :discount

      t.timestamps
    end
  end
end
