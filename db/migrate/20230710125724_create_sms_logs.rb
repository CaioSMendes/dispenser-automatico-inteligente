class CreateSmsLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :sms_logs do |t|
      t.string :from_number
      t.string :to_number
      t.text :body
      t.datetime :sent_at

      t.timestamps
    end
  end
end
