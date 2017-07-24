class Upload < ApplicationRecord
    has_attached_file :image,
                      # storage: :s3,
                      # s3_credentials: {
                      #     bucket: Yml::AWS_S3[Rails.env.to_sym][:bucket],
                      #     access_key_id: Yml::AWS_S3[Rails.env.to_sym][:access_key_id],
                      #     secret_access_key: Yml::AWS_S3[Rails.env.to_sym][:secret_access_key],
                      #     s3_region: Yml::AWS_S3[Rails.env.to_sym][:s3_region],
                      # },
                      # s3_protocol: "https",
                      styles: { large: "900x900#", medium: "300x300#", thumb: "100x100#"},
                      default_url: "noimage.png",
                      path: "public/upload_image/:id/:style_:basename.:extension",
                      url: "/upload_image/:id/:style_:basename.:extension"

    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    validates_attachment_size :image, less_than: 2.megabytes

    before_create :generate_access_token
    cattr_accessor :access_token

    private
    # simple random salt
    def random_salt(len = 20)
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      salt = ""
      1.upto(len) { |i| salt << chars[rand(chars.size-1)] }
      return salt
    end

    # # SHA1 from random salt and time
    def generate_access_token
      self.access_token = Digest::SHA1.hexdigest("#{random_salt}#{Time.now.to_i}")
    end

    def self.get_avatar_img(upload, style)
      if upload.nil?
        return "noimage.png"
      else
        img_url = upload.image.url(style)
        if img_url.index("///")
          return upload.image.url(style).gsub("///",'//')
        else
          return upload.image.url(style)
        end
      end
    end

    def self.get_avatar(avatar_id,style = "medium")
      avatar = nil
      if !avatar_id.blank?
        avatar = Upload.find_by_id(avatar_id)
      end
      return Upload.get_avatar_img(avatar, style)
    end
end
