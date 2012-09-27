class CreateCostumesParts < ActiveRecord::Migration
  def up
    create_table :costumes_parts, :id => false do |t|
      t.integer :costume_id
      t.integer :part_id
    end
  end

  def down
    drop_table :costumes_parts
  end
end
