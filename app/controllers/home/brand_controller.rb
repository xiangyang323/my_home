class Home::BrandController < HomeController

  before_action :check_login

  def new
    @brand = Brand.new
    if request.post?
      @brand.attributes = brand_form_params
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
                :business_licence,
                :business_scope,
                :content
        )
  end
  private :brand_form_params

end