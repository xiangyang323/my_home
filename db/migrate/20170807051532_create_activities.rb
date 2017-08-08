class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :phone
      t.datetime :start_time
      t.datetime :end_time
      t.string :province, limit: 50
      t.string :city, limit: 50
      t.string :district, limit: 50
      t.string :detail_address, limit: 80

      t.integer :user_id
      t.integer :check_flag, default: 0, limit: 4
      t.timestamps
    end
  end
end
