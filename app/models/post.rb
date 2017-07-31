class Post < ApplicationRecord

  # 新创建的一个,没有填任何内容
  NEW_FLAG = 0
  # 有内容, 为编辑状态
  EDIT_FLAG = 1
  # 发布状态
  PUB_FLAG = 2

  has_attached_file :avatar1,
                    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" },
                    default_url: "upload_image.png",
                    path: 'public/system/:id/avatar1/:hash.:extension',
                    url: '/system/:id/avatar1/:hash.:extension',
                    hash_secret: "longSecretString"

  has_attached_file :avatar2,
                    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" },
                    default_url: "upload_image.png",
                    path: 'public/system/:id/avatar2/:hash.:extension',
                    url: '/system/:id/avatar2/:hash.:extension',
                    hash_secret: "longSecretString"

  has_attached_file :avatar3,
                    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" },
                    default_url: "upload_image.png",
                    path: 'public/system/:id/avatar3/:hash.:extension',
                    url: '/system/:id/avatar3/:hash.:extension',
                    hash_secret: "longSecretString"

  validates_attachment_content_type :avatar1, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :avatar1, less_than: 2.megabytes

  validates_attachment_content_type :avatar2, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :avatar2, less_than: 2.megabytes

  validates_attachment_content_type :avatar3, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :avatar3, less_than: 2.megabytes


  before_save :randomize_file_name

  def randomize_file_name
    unless avatar1_file_name.nil? || avatar1_file_name_changed?
      extension = File.extname(avatar1_file_name).downcase
      self.avatar1.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
    unless avatar2_file_name.nil? || avatar2_file_name_changed?
      extension = File.extname(avatar2_file_name).downcase
      self.avatar2.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
    unless avatar3_file_name.nil? || avatar3_file_name_changed?
      extension = File.extname(avatar3_file_name).downcase
      self.avatar3.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
  end

  def get_avatar_img(style, image="avatar1")
    return self.try(image).url(style)
  end

  def check_img(image)
    ("upload_image.png" == self.try(image).url(:medium))? true:false
  end
end
