class AddImgToBrand < ActiveRecord::Migration[5.0]
  def self.up
    change_table :brands do |t|
      t.attachment :logo
      t.attachment :licence
    end
  end

  def self.down
    remove_attachment :brands, :logo
    remove_attachment :brands, :licence
  end
end
