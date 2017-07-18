class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, limit: 100
      t.string :province, limit: 50
      t.string :city, limit: 50
      t.string :district, limit: 50
      t.string :detail_address, limit: 80
      t.string :building, limit: 30
      # 住室
      t.integer :room_cnt
      # 客厅
      t.integer :living_room_cnt
      # 卫生间
      t.integer :toilet_cnt
      # 厨房
      t.integer :kitchen_cnt
      # 房屋大小
      t.integer :home_size

      t.text :content

      t.timestamps null: false
    end
  end
end
