class CreateConnections < ActiveRecord::Migration[7.1]
  def change
    create_table :connections do |t|
      t.integer :user_id, null: false
      t.integer :connected_user_id, null: false

      t.timestamps
    end

    add_index :connections, :user_id
    add_index :connections, :connected_user_id
    add_index :connections, [:user_id, :connected_user_id], unique: true

    add_foreign_key :connections, :users, column: :user_id
    add_foreign_key :connections, :users, column: :connected_user_id
  end
end
