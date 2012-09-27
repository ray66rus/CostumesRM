class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name
      t.text :comment

      t.timestamps
    end
  end
end
