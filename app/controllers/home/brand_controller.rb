class Home::BrandController < HomeController

  before_action :check_login

  def new
    @brand = Brand.new

    if request.post?
      @brand.attributes = brand_form_params
      if @brand.valid?
        @brand.save
        UserBrand.create(user_id: current_user.id, brand_id: @brand.id)
        redirect_to :list, type: Brand::HAVE_BIND
      else
        p @brand.errors
      end
    end
  end

 ##品牌列表
  def list
    @type = params[:type].blank? ? Brand::HAVE_BIND : params[:type].to_i
    @brands = Brand.get_brands(current_user.id, @type)
  end

  ##绑定品牌
  def operate
    data = {status: -1}
    if request.xhr?
      brand_id = params[:brand_id]
      user_id = current_user.id
      type = params[:type]

      max_count = 20

      user_brand = UserBrand.where(user_id: user_id, brand_id: brand_id).first
      ##解除绑定 type=1
      if type.to_i == Brand::HAVE_BIND
        if user_brand.blank?
          data[:status] = -1 ##解除失败
        else
          user_brand.destroy
          data[:status] = 1 ##解除成功
        end
      else
        if user_brand.blank?
          count = UserBrand.where(user_id: user_id, brand_id: brand_id).count
          if count < max_count
            user_brand = UserBrand.create(user_id: user_id, brand_id: brand_id)
            data[:status] = 2 ##绑定成功
          else
            data[:status] = 0 ##绑定失败，超过数目
          end
        else
          data[:status] = -1 ##绑定失败
        end
      end
    end
    return render_to_json(data)
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