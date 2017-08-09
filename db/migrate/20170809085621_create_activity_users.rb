class CreateActivityUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_users do |t|
      t.integer :activity_id
      t.string :user_name
      t.string :phone

      t.timestamps
    end
  end
end
