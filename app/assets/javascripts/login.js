var VERIFICATION_LIMIT_TIME = 60;
$().ready(function() {
  $("#signinForm").validate({
    rules: {
      "session[phone]": {
        required:true,
        isMobile: true
      },

    },
    messages: {
      "session[phone]": {
        required: "手机号不能为空",
        isMobile: "请输入有效手机号"
      },
    },
    submitHandler: function(form) { //验证成功时调用
      alert(form);
    },
    invalidHandler: function(form, validator) {  //不通过回调
      alert('验证不通过');
      return false;
    }

  });
});

function submitLogin(){
   // var phoneNumber = $('form #session_phone').val();
   //// if(!checkPhone(phoneNumber)) return;
   // var password = $('form #session_password').val();
   // if($.trim(password) == ""){
   //     alert("密码不能为空");
   //     return;
   // }

    $("form").submit();
}

function submitSignIn(){
    $("#signinForm").submit();
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
            alert(data.value);
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
