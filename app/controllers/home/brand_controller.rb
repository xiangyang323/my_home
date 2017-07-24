class Home::BrandController < HomeController

  before_action :check_login

  def new
    @brand = Brand.new

    if request.post?
      @brand.attributes = brand_form_params
      if @brand.valid?
        @brand.save
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

end