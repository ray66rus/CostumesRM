class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :contact
      t.text :comment

      t.timestamps
    end

    add_index :clients, :name, unique: true
  end
end
