class CreateUserBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :user_brands do |t|
      t.integer :user_id, null: false
      t.integer :brand_id, null: false

      t.datetime :delete_at

      t.timestamps
    end
  end
end
