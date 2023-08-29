class CreateDosePrice < ActiveRecord::Migration[7.0]
  def change
    create_table :dose_prices do |t|
      t.decimal :price, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
