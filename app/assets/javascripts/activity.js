$(function () {
  var currYear = (new Date()).getFullYear();
  var opt={};
  opt.date = {preset : 'date'};
  opt.datetime = {preset : 'datetime'};
  opt.time = {preset : 'time'};
  opt.default = {
    theme: 'android-ics light', //皮肤样式
    display: 'modal', //显示方式
    mode: 'scroller', //日期选择模式
    dateFormat: 'yyyy-mm-dd',
    lang: 'zh',
    showNow: true,
    nowText: "今天",
    startYear: currYear - 50, //开始年份
    endYear: currYear + 10 //结束年份
  };
  $("#start_time").mobiscroll($.extend(opt['datetime'], opt['default']));
  $("#end_time").mobiscroll($.extend(opt['datetime'], opt['default']));

});

function uploadActivityImage(obj){
  var file_id = $(obj).attr("id");
  var activity_id = $(obj).attr("activity_id");
  var image_id = file_id.replace("file_", "");
  uploadImage(obj, "/home/activity/upload_image?activity_id=" + activity_id + "&image_id=" + image_id, "#" + image_id, "activity[" + image_id + "]")
}

function addInfoBtn(){
  $('#file_avatar2').trigger('click');
}

function showAddress(obj){
  $(".common_modal").show();
}