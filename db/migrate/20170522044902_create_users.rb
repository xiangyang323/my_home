class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, unique: true
      t.string :password
      t.string :phone, unique: true, limit: 20
      t.string :verification_code
      t.integer :verification_limit, default: 0, limit: 2
      t.datetime :verification_time
      t.integer :user_type, limit: 6
      t.integer :status, limit: 2, default: 1
      t.integer :is_verify, limit:2, default: 0

      t.timestamps null: false
    end
  end
end
