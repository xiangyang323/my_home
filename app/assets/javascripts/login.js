var VERIFICATION_LIMIT_TIME = 60;

function submitLogin(){
    var phoneNumber = $('form #session_phone').val();
    if(!checkPhone(phoneNumber)) return;
    var password = $('form #session_password').val();
    if($.trim(password) == ""){
        alert("密码不能为空");
        return;
    }

    $("form").submit();
}

function submitSignIn(){
    var phoneNumber = $('form #session_phone').val();
    if(!checkPhone(phoneNumber)) return;
    var code = $('form #session_verification_code').val();
    if($.trim(code) == ""){
        alert("验证码不能为空");
        return;
    }
    var password = $('form #session_password').val();
    var passwordC = $('form #session_password_confirmation').val();
    if($.trim(password) == "" || $.trim(passwordC) == ""){
        alert("密码不能为空");
        return;
    }
    if(password != passwordC){
        alert("两次密码输入异常，请重新确认");
        return;
    }
    $("form").submit();
}

function getVerificationCode(){
    var time = parseInt($("#verification_code_btn").attr("time"));
    if(time < VERIFICATION_LIMIT_TIME) return;
    var formObj = $('form #session_phone');
    var phoneNumber = formObj.val();
    console.log(phoneNumber);
    if(!checkPhone(phoneNumber)) return;
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

function timedCount(){
    var time = parseInt($("#verification_code_btn").attr("time"));
    time = time - 1;
    if(time == 0){
        $("#verification_code_btn").attr("time", VERIFICATION_LIMIT_TIME);
        $("#verification_code_btn").html("获得手机验证码");
        return;
    }
    $("#verification_code_btn").html(time + "秒");
    $("#verification_code_btn").attr("time", time);
    setTimeout("timedCount()", 1000);
}

function checkPhone(phoneNumber){
    var reg = /^1[3|4|5|8][0-9]\d{4,8}$/;
    if(!reg.test($.trim(phoneNumber))){
        alert("请输入有效手机号");
        return false;
    }
    return true;
}
