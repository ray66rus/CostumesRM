class CreateCostumesOrders < ActiveRecord::Migration
  def up
    create_table :costumes_orders, :id => false do |t|
      t.integer :costume_id
      t.integer :order_id
    end
  end

  def down
    drop_table :costumes_orders
  end
end
