class CreateDeviceSellers < ActiveRecord::Migration[7.0]
  def change
    create_table :device_sellers do |t|
      t.references :device, foreign_key: true
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
