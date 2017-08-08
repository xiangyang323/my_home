class AddAttachmentAvatarToActivities < ActiveRecord::Migration[5.0]
  def self.up
    change_table :activities do |t|
      t.attachment :avatar1
      t.attachment :avatar2
    end
  end

  def self.down
    remove_attachment :activities, :avatar1
    remove_attachment :activities, :avatar2
  end
end
