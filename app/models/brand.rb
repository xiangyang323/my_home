class Brand < ApplicationRecord

  belongs_to :brand_category


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

  def randomize_file_name
    unless avatar_file_name.nil? || avatar_file_name_changed?
      extension = File.extname(avatar_file_name).downcase
      self.avatar.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
  end

end
