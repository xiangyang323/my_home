class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id, unique: true
      t.string :user_name, unique: true
      # 介绍
      t.string :motto
      t.string :province, limit: 50
      t.string :city, limit: 50
      t.string :district, limit: 50
      t.string :detail_address, limit: 80
      t.timestamps null: false
    end

    add_index :user_profiles, :user_id
  end
end
