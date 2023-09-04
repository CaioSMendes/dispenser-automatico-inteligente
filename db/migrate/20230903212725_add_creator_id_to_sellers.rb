class AddCreatorIdToSellers < ActiveRecord::Migration[7.0]
  def change
    add_column :sellers, :creator_id, :integer
    add_foreign_key :sellers, :users, column: :creator_id
  end
end
