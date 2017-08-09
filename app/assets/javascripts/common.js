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
        $(upLoadImageId).show();
        $(upLoadImageId + "_addbtn").hide();
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

function modelAddress(){
  hideModel('model_address');

  var province = $("#model_province").val();
  var city = $("#model_city").val();
  var district = $("#model_district").val();
  var detail_address = $("#model_detail_address").val();

  var tmp_address = "";
  if(province){
    tmp_address += province;
    $("#province").val(province);
  }
  if(city){
    tmp_address += city;
    $("#city").val(city);
  }
  if(district){
    tmp_address += district;
    $("#district").val(district);
  }
  if(detail_address){
    tmp_address += detail_address;
    $("#detail_address").val(detail_address);
  }

  $("#tmp_address").val(tmp_address);
}

function showModel(open_id){
  $(".common_modal").show();
  $("#" + open_id).show();
}

function hideModel(close_id){
  $(".common_modal").hide();
  $("#" + close_id).hide();
}

//绑定品牌
//type=1 已绑定的品牌 type=0 未绑定品牌
function operateBrand(brandId,type){
    if(type == null) return;
    var brand = $("#brand_info_" + brandId);
    if(brandId != null && brand.length > 0) {
        var url = '/home/brand/operate/' + brandId + '/' + type;
        $.get(url,
            function (data) {
                if (data.status > 0) {
                    //添加
                    if (data.status == 1 || data.status == 2) {
                        alert("操作成功!");
                        brand.fadeOut(2000);
                    } else if (data.status == -1) {
                        alert("操作失败,请稍后重试!");
                        return;
                    }
                } else if (data.status == 0) {
                    alert("绑定品牌最多为20条,请解除后重试!");
                    return;
                }
            });
    }
}
