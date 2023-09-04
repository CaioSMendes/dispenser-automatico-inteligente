class AddUserIdToSellers < ActiveRecord::Migration[7.0]
  def change
    add_reference :sellers, :user, foreign_key: true
  end
end
