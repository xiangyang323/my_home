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
      t.integer :room_cnt, default: 0
      # 客厅
      t.integer :living_room_cnt, default: 0
      # 卫生间
      t.integer :toilet_cnt, default: 0
      # 厨房
      t.integer :kitchen_cnt, default: 0
      # 房屋大小
      t.integer :home_size

      t.integer :user_id

      t.text :content1
      t.text :content2
      t.text :content3

      t.integer :check_flag, default: 0, limit: 4
      t.integer :status, default: 0, limit: 4

      t.timestamps null: false
    end
  end
end
