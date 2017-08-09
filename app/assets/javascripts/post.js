function showContent(id){
  $("#add_content" + id).hide();
  $("#content" + id).show();
  var new_id = parseInt(id) + 1;
  $("#add_content" + new_id).show();
}

function uploadPostImage(obj){
  var file_id = $(obj).attr("id");
  var image_id = file_id.replace("file_", "");
  var post_id = $(obj).attr("post_id");
  uploadImage(obj, "/home/post/upload_image?post_id=" + post_id + "&image_id=" + image_id, "#" + image_id, "post[" + image_id + "]")
}

function addFavorite(post_id){
  if(checkLogin()){
    $.get({url: "/favorite/" + post_id}, function(data){
      console.log(data.value);
      var num = parseInt($("span.like_num_color").html());
      console.log(num);
      if(data.value == "delete"){
        $("span.like_w").html("收藏");
        $("span.like_num_color").html(num - 1);
      }else{
        $("span.like_w").html("取消收藏");
        $("span.like_num_color").html(num + 1);
      }
    })

  }else{
    window.location.href = "/login"
  }
}