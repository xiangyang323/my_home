class PostController < ApplicationController

  def show
    @post = Post.find_by(id: params[:id])
    PostAccessLog.create(ip: request.remote_ip, post_id: @post.id)
  end

  def change_flag

  end
end
