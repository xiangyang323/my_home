class Home::UploadController < HomeController

  protect_from_forgery except: :create

  def create
    _style = params[:style].blank? ? 'original' : params[:style]
    @upload = Upload.new(upload_params)

    respond_to do |format|
      if @upload.valid?
        @upload.save

        format.json { render :json => { url: @upload.image.url(_style), upload_id: @upload.id } }
      else
        format.json { render :json => { :errors => @upload.errors.full_messages }, :status => 422 }
      end
    end
  end

  def update
    upload_id = params[:id]

    @upload = Upload.find_by_id(upload_id)

    if @upload.nil?
      @upload = Upload.new(upload_params)
      # format.json { render :json => { :errors => @upload.errors.full_messages }, :status => 422 }
    else
      @upload.attributes = upload_params
      @upload.image.reprocess!
    end

    respond_to do |format|
      if @upload.valid?
        @upload.save
        format.json { render :json => { url: @upload.image.url(:original), upload_id: @upload.id } }
      else
        format.json { render :json => { :errors => @upload.errors.full_messages }, :status => 422 }
      end
    end
  end

  # def create_avatar
  #   upload_type = params[:upload_type]
  #   blog_user_id = params[:id]
  #
  #   if upload_type == "blog_user" && blog_user_id.blank?
  #     blog_user_id = 0
  #   end
  #
  #   #获取Upload表存储存的文件ID
  #   blog_user = BlogUser.find_by_id(blog_user_id)
  #
  #   @upload = blog_user.get_avatar if !blog_user.blank?
  #
  #   if @upload.nil?
  #     @upload = Upload.new(upload_params)
  #     @upload.upload_type = upload_type
  #   else
  #     @upload.attributes = upload_params
  #     @upload.upload_type = upload_type
  #     @upload.image.reprocess!
  #   end
  #
  #   respond_to do |format|
  #     if @upload.valid?
  #       Upload.transaction do
  #         @upload.save
  #
  #         if !blog_user.blank?
  #           blog_user.avatar = @upload.id
  #           blog_user.save!
  #         end
  #       end
  #
  #       format.json { render :json => { url: @upload.image.url(:large), upload_id: @upload.id } }
  #     else
  #       format.json { render :json => { :errors => @upload.errors.full_messages }, :status => 422 }
  #     end
  #   end
  # end

  private

  def upload_params
    params.require(:upload).permit(:image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :md5, :upload_type)
  end

end
