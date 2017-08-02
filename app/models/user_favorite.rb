class UserFavorite < ApplicationRecord
  belongs_to :user_profile, foreign_key: :user_id, primary_key: :user_id
  belongs_to :post, foreign_key: :post_id, primary_key: :post_id
end
