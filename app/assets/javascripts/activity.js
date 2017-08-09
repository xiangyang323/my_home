function uploadActivityImage(obj){
  var file_id = $(obj).attr("id");
  var activity_id = $(obj).attr("activity_id");
  var image_id = file_id.replace("file_", "");
  uploadImage(obj, "/home/activity/upload_image?activity_id=" + activity_id + "&image_id=" + image_id, "#" + image_id, "activity[" + image_id + "]")
}

function addInfoBtn(){
  $('#file_avatar2').trigger('click');
}