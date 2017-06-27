class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.integer :user_id, null: false
      t.string :name, null: false, default: ""
      t.integer :logo, null: false
      t.integer :brand_category_id, null: false, default: 0
      t.string :place, null: false
      t.string :leader, null: false, default: ""
      t.integer :tel, null: false, default: 0
      t.integer :tel_code
      t.integer :business_licence, null: false
      t.text :business_scope, null: false, default: ""
      t.text :content, null: false, default: ""
      t.integer :check_flag, null: false, default: 0
      t.integer :status
      t.timestamps
    end

    add_index :brands, :user_id, unique: true
    add_index :brands, :check_flag, unique: true
  end
end
