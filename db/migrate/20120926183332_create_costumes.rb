class CreateCostumes < ActiveRecord::Migration
  def change
    create_table :costumes do |t|
      t.string :name
      t.integer :price
      t.string :type
      t.string :availability
      t.text :comment
     
      t.timestamps
    end
 end
end


