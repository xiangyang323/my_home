class UpdatePost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :brand_ids, :string
  end
end
