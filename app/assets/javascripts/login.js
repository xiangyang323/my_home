var VERIFICATION_LIMIT_TIME = 60;
$().ready(function() {
  $("form").validate({
    rules: {
      "session[phone]": {
        required:true,
        isMobile: true
      },
      "session[verification_code]":{
        required:true,
      },
      "session[password]":{
        required:true,
        rangelength: [6,16]
      },
      "session[password_confirmation]":{
        required:true,
        equalTo:"#session_password"
      }
    },
    messages: {
      "session[phone]": {
        required: "手机号不能为空",
        isMobile: "请输入有效手机号"
      },
      "session[verification_code]": {
        required: "验证码不能为空",
      },
      "session[password]": {
        required: "密码不能为空",
        rangelength: "密码必须要8~16位"
      },
      "session[password_confirmation]": {
        required: "密码不能为空",
        equalTo: "两次输入密码必须相同"
      },
    },
    submitHandler: function(form) { //验证成功时调用
      //alert(form);
      return true
    },
    invalidHandler: function(form, validator) {  //不通过回调
      //alert('验证不通过');
      return false;
    }

  });
});

function uploadUserImage(obj){
  console.log("1111");
  var file = obj.files[0];
  if (file == undefined) {
    return;
  }
  var name = file.name;
  var size = file.size;
  var type = file.type;
  console.log(file);

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
  data.append('user_profile[avatar]', file, name);

  $.ajax({
    data: data,
    type: 'POST',
    url: "/home/upload_image",
    cache: false,
    contentType: false,
    processData: false,
    success: function(data, status){
      if(data.url != undefined){
        $("#my_image img").attr("src", data.url);
      }
    },
    error: function(data, status, e){
      alert("图片上传失败");
    }
  });
}

function submitLogin(){
  $("form").submit();
}

function submitSignIn(){
  $("form").submit();
}

function getVerificationCode(){
  var time = parseInt($("#verification_code_btn").attr("time"));
  if(time < VERIFICATION_LIMIT_TIME) return;
  var formObj = $('form #session_phone');
  if(formObj.valid()){
    var phoneNumber = formObj.val();
    console.log(phoneNumber);
    $.get({url: "/session/get_verification?phone=" + phoneNumber,
      success: function(data) {
        console.log(data);
        if(data.status != 1){
          $("#verification_code_btn").attr("time", VERIFICATION_LIMIT_TIME);
        }else{
          timedCount();
        }
      }
    });
  }
}

function timedCount(){
  var time = parseInt($("#verification_code_btn").attr("time"));
  time = time - 1;
  if(time == 0){
    $("#verification_code_btn").attr("time", VERIFICATION_LIMIT_TIME);
    $("#verification_code_btn").html("获得验证码");
    return;
  }
  $("#verification_code_btn").html(time + "秒");
  $("#verification_code_btn").attr("time", time);
  setTimeout("timedCount()", 1000);
}

function userEditorSubmit(){
  $("form").submit();
}