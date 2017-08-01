class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.integer :user_id, null: false
      t.string :name, null: false, default: ""
      t.string :logo
      t.integer :brand_category_id, null: false, default: 0
      t.string :province, limit: 50
      t.string :city, limit: 50
      t.string :district, limit: 50
      t.string :detail_address, limit: 80
      t.string :leader, null: false, default: ""
      t.string :tel, limit: 20
      t.integer :tel_code
      t.text :business_scope, null: false
      t.string :licence
      t.text :content, null: false
      t.integer :check_flag, null: false, default: 0
      t.integer :status
      t.timestamps
    end

    add_index :brands, :user_id
    add_index :brands, :check_flag
  end
end
