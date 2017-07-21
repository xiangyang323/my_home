class Brand < ApplicationRecord

  belongs_to :brand_category


  before_save :randomize_file_name

  has_attached_file :logo,
      styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" },
      default_url: "noimage.png",
      path: 'public/brand/logo/:id/:hash.:extension',
      url: '/brand/logo/:id/:hash.:extension',
      hash_secret: "longSecretString"

  validates_attachment_content_type :logo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :logo, less_than: 2.megabytes


  has_attached_file :licence,
                    styles: { large: "400x400#", medium: "200x200#", thumb: "100x100#" },
                    default_url: "noimage.png",
                    path: 'public/brand/licence/:id/:hash.:extension',
                    url: '/brand/licence/:id/:hash.:extension',
                    hash_secret: "longSecretString"

  validates_attachment_content_type :licence, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_size :licence, less_than: 2.megabytes

  def randomize_file_name
    unless logo_file_name.nil? || logo_file_name_changed?
      extension = File.extname(logo_file_name).downcase
      self.logo.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
    unless licence_file_name.nil? || licence_file_name_changed?
      extension = File.extname(licence_file_name).downcase
      self.licence.instance_write(:file_name, "#{SecureRandom.hex(16)}#{extension}")
    end
  end

  def get_avatar_img(style)
    if logo.nil?
      return "noimage.png"
    else
      return logo.url(style)
    end
  end

end
