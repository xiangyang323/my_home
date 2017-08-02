class CreatePostAccessLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :post_access_logs do |t|
      t.integer :post_id
      t.string :ip, limit: 20

      t.timestamps
    end
  end
end
