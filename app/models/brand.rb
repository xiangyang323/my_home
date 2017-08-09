class Brand < ApplicationRecord
  belongs_to :brand_category
  has_many :user_brand, foreign_key: "brand_id", dependent: :destroy


  HAVE_BIND = 1
  NO_BIND = 0

  HAVE_BIND_MSG = "已绑定"
  NO_BIND_MSG = "未绑定"

  def self.get_brands(user_id,type)

    case type
      when HAVE_BIND
        user_brands = UserBrand.where(user_id: user_id)
        brands = self.where(id: user_brands.map(&:brand_id))
      when NO_BIND
        brands = self.where("id not in (select brand_id from user_brands where user_id = #{user_id})")
      else
        brands = self.all
    end
    return brands.order("updated_at desc")
  end
end
