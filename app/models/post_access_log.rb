class PostAccessLog < ApplicationRecord

  def self.view_count(post_id)
    PostAccessLog.where("created_at >= ? and post_id = ?", 1.month.ago.to_date.to_time, post_id).count
  end
end