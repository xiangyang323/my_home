module HomeHelper

  def show_post_btn(post)
    if post.is_edit?
      link_to "公开", {controller: "/home/post", action: "change_flag", id: post.id, flag: Post::PUB_FLAG}, remote: true
    elsif post.is_pub?
      link_to "私有", {controller: "/home/post", action: "change_flag", id: post.id, flag: Post::EDIT_FLAG}, remote: true
    end
  end
end
