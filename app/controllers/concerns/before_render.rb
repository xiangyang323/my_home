module BeforeRender
  extend ActiveSupport::Concern

  # include SetHtmlTkd
  # include SetBreadcrumb

  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    # base.class_eval do
    #   scope :active, where(is_active: true)
    # end
  end


  module ClassMethods
  end


  module InstanceMethods
    @first_render = false
    def render(*args)
      Rails.logger.debug "[before_render] ###### Start ######"
      Rails.logger.debug "[before_render] controller_name: #{controller_name}, action_name: #{action_name}"
      Rails.logger.debug "[before_render] Params: #{params}"
      render_page_tag = false
      render_page_tag = true if args.size == 0                  # action render 默认设置
      if args.size > 0
        render_page_tag = true if args[0].is_a?(String)         # action render 直接指定页面
        if args[0].is_a?(Hash)
          render_page_tag = true if !args[0][:action].blank?    # action render 默认设置
          render_page_tag = true if !args[0][:file].blank?      # action render 指定 file 页面
          render_page_tag = true if !args[0][:template].blank?  # action render 指定 template 页面
          render_page_tag = true if !args[0][:layout].blank?    # action render 指定 layout 页面
        end
      end
      render_page_tag = false if request.xhr?                   # ajax 不参与任何设置

      if render_page_tag && !@first_render
        @first_render = true
        begin
          set_html_tkd if defined?(set_html_tkd)
          set_breadcrumb if defined?(set_breadcrumb)
        rescue Exception => e
          Rails.logger.error e.message + "\n" + e.backtrace.join("\n")
        end
      end
      Rails.logger.debug "[before_render] ###### End ######"
      super
    end

    protected
    ######## json ########## start
    JSON_DATA_FAILED  = 0
    JSON_DATA_ERROR   = -1
    JSON_DATA_SUCCESS = 1
    JSON_DATA_HASH = {
        JSON_DATA_FAILED  => I18n.t('views.message.failed.com'),
        JSON_DATA_ERROR   => I18n.t('views.message.error.com'),
        JSON_DATA_SUCCESS => I18n.t('views.message.success.com')
    }
    # 初始化返回json，默认：失败（0）
    def init_json_data
      @json_data = {state: JSON_DATA_FAILED, message: JSON_DATA_HASH[JSON_DATA_FAILED]}
      @json_data
    end

    # 设置“失败”json，状态：0
    def set_json_failed(opt={})
      opt[:message] ||= I18n.t('views.message.failed.com')
      @json_data ||= init_json_data
      @json_data = @json_data.merge(opt) if !opt.blank?
      @json_data[:state] = JSON_DATA_FAILED
      @json_data
    end

    # 设置“成功”json，状态：1
    def set_json_success(opt={})
      opt[:message] ||= I18n.t('views.message.success.com')
      @json_data ||= init_json_data
      @json_data = @json_data.merge(opt) if !opt.blank?
      @json_data[:state] = JSON_DATA_SUCCESS
      @json_data
    end

    # 设置“错误”json，状态：-1
    def set_json_error(opt={})
      opt[:message] ||= I18n.t('views.message.error.com')
      @json_data ||= init_json_data
      @json_data = @json_data.merge(opt) if !opt.blank?
      @json_data[:state] = JSON_DATA_ERROR
      @json_data
    end

    # 设置“错误-无权操作”json，状态：-1
    def set_json_error_deny
      set_json_error({message: I18n.t('views.message.permission_deny')})
    end

    # 设置“错误-参数错误”json，状态：-1
    def set_json_error_params
      set_json_error({message: I18n.t('views.message.error.params')})
    end

    # 返回json
    def render_to_json(datas=nil)
      datas ||= @json_data || init_json_data
      render :json => datas.to_json
    end

    # 判断json状态是否failed
    def json_failed?
      set_json_failed if !@json_data
      return @json_data[:state] == JSON_DATA_FAILED
    end

    # 判断json状态是否ok
    def json_success?
      set_json_success if !@json_data
      return @json_data[:state] == JSON_DATA_SUCCESS
    end

    # 判断json状态是否error
    def json_error?
      set_json_error if !@json_data
      return @json_data[:state] == JSON_DATA_ERROR
    end

    # 判断 request.xhr? before_action 使用
    def is_xhr?
      # params[:xhr] 伪xhr,带此参数可跳过error返回,直接跳到下一步
      set_json_error(I18n.t('views.message.error.params'))
      return render_to_json() if params[:xhr].blank? && !request.xhr?
    end
    ######## json ########## end
  end

end