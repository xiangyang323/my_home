class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name, unique: true
      t.string :phone, unique: true, limit: 20
      t.string :password_digest
      t.string :remeber_digest
      t.integer :user_type, limit: 6

      t.string :verification_digest
      t.integer :verification_limit, default: 0, limit: 2
      t.datetime :verification_time
      t.integer :is_verify, limit:2, default: 0

      t.integer :status, limit: 2, default: 1
      t.string :user_name, limit: 20
      t.string :ip, limit: 20
      t.datetime :login_at
      t.timestamps null: false
    end
  end
end
