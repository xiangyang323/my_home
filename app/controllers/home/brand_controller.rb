class Home::BrandController < HomeController

  before_action :check_login

  def new
    @brand = Brand.new

    if request.post?
      @brand.attributes = brand_form_params
      if @brand.valid?
        @brand.save
        redirect_to :list
      else
        p @brand.errors
      end
    end
  end

  def brand_form_params
    params.require(:brand)
        .permit(:user_id,
                :name,
                :logo,
                :brand_category_id,
                :province,
                :city,
                :district,
                :detail_address,
                :leader,
                :tel,
                :licence,
                :business_scope,
                :content
        )
  end
  private :brand_form_params

 ##品牌列表
  def list
    @brands = Brand.all.order("updated_at desc")
  end

  ##绑定品牌
  def bind

  end



end