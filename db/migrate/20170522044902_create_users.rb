class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, unique: true
      t.string :password
      t.integer :phone, unique: true, limit: 11
      t.string :verification_code
      t.integer :user_type, limit: 6
      t.integer :status, limit: 2, default: 1
      t.integer :is_verify, limit:2, default: 0

      t.timestamps null: false
    end
  end
end
