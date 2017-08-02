function uploadImage(fileObj, url, upLoadImageId, imageStr){
  var file = fileObj.files[0];
  if (file == undefined) {
    return;
  }
  var name = file.name;
  var size = file.size;
  var type = file.type;

  var regex = new RegExp("(.*?)\.(png|jpg|jpeg|gif)$");
  if (!regex.test(type)) {
    alert("请上传图片文件.");
    return;
  }

  if (size > 2000000) {
    alert("图片大小请小于2兆.");
    return;
  }

  var data;
  data = new FormData;
  data.append(imageStr, file, name);

  $.ajax({
    data: data,
    type: 'POST',
    url: url,
    cache: false,
    contentType: false,
    processData: false,
    success: function(data, status){
      if(data.url != undefined){
        $(upLoadImageId).attr("src", data.url);
      }
    },
    error: function(data, status, e){
      alert("图片上传失败");
    }
  });
}

CK_LOGIN_KEY = 'user_info';
function checkLogin() {
  if (typeof(Cookies.get(CK_LOGIN_KEY)) == 'undefined') return false;
  if (Cookies.get(CK_LOGIN_KEY) == null) return false;
  if (Cookies.get(CK_LOGIN_KEY) == '') return false;
  if (Cookies.get(CK_LOGIN_KEY).length < 33) return false;
  return true;
}
