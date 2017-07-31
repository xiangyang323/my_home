function showContent(id){
  $("#add_content" + id).hide();
  $("#content" + id).show();
  var new_id = parseInt(id) + 1;
  $("#add_content" + new_id).show();
}

function uploadPostImage(obj){
  var file_id = $(obj).attr("id");
  var image_id = file_id.replace("file_", "");
  uploadImage(obj, "/home/post/upload_image?image_id=" + image_id, "#" + image_id, "post[" + image_id + "]")
}