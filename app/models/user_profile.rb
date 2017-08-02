class UserProfile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :post
  has_many :user_favorite

  validates_presence_of :user_name, :user_id
  validates_uniqueness_of :user_name
  validates_length_of :user_name, :maximum => 20
  validates_length_of :motto, :maximum => 100

  before_save :randomize_file_name

  has_attached_file :avatar,
                    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" },
                    default_url: "noimage.png",
                    path: 'public/system/avatar/:id/:hash.:extension',
                    url: '/system/avatar/:id/:hash.:extension',
                    hash_secret: "longSecretString"

  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :avatar, less_than: 2.megabytes

  def get_avatar_img(style)
    if avatar.nil?
      return "noimage.png"
    else
      return avatar.url(style)
    end
  end

  def get_motto
    self.motto.blank?? "暂无简介." : self.motto
  end

  def randomize_file_name
    unless avatar_file_name.nil? || avatar_file_name_changed?
      extension = File.extname(avatar_file_name).downcase
      self.avatar.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
  end
end
