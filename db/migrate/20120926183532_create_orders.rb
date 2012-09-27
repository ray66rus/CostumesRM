class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :price
      t.string :payed_status
      t.string :activity_status
      t.datetime :take_time
      t.datetime :planed_return_time
      t.datetime :real_return_time
      t.integer :user_id
      t.integer :client_id

      t.timestamps
    end
  end
end
