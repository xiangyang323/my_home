class AddAttachmentAvatar1ToPosts < ActiveRecord::Migration
  def self.up
    change_table :posts do |t|
      t.attachment :avatar1
      t.attachment :avatar2
      t.attachment :avatar3
    end
  end

  def self.down
    remove_attachment :posts, :avatar1
    remove_attachment :posts, :avatar2
    remove_attachment :posts, :avatar3
  end
end
