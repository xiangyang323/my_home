class Home::BrandController < HomeController

  before_action :check_login

  def new
    @brand = Brand.new

    if request.post?
      @brand.attributes = brand_form_params
      if @brand.valid?
        @brand.save
        UserBrand.create(user_id: current_user.id, brand_id: @brand.id)
        redirect_to :list
      else
        p @brand.errors
      end
    end
  end

 ##品牌列表
  def list
    type = params[:type].blank? ? Brand::HAVE_BIND : params[:type].to_i
    @brands = Brand.get_brands(current_user.id,type)
  end

  ##绑定品牌
  def operate
    data = {status: -1}
    if request.xhr?
      brand_id = params[:brand_id]
      user_id = current_user.id

      max_count = 20

      count = UserBrand.where(user_id: user_id, brand_id: brand_id).count

      user_brand = UserBrand.where(user_id: user_id, brand_id: brand_id).first
      if count < max_count
        if user_brand.blank?
          user_brand = UserBrand.create(user_id: user_id, brand_id: brand_id)
          data[:status] = 1 ##绑定成功
        else
          user_brand.destroy
          data[:status] = 2 ##解除成功
        end
      else
        if user_brand.blank?
          data[:status] = 0 ##添加失败，超过限制
        else
          user_brand.destroy
          data[:status] = 2 ##解除成功
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