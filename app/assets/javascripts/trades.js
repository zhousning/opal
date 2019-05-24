$(".trades").ready(function() {
  $("#buy-send-confirm-code").click(function(){
    $(this).attr("disabled", "disabled");
    var max = 60;
    var that = this;
    var timer = setInterval(function(){
      $(that).html(max + "秒");
      if (max == 0){
        $(that).removeAttr("disabled");
        $(that).html("重新发送");
        clearInterval(timer);
      }
      max--;
    }, 1000);
    var url = "/systems/send_confirm_code" ;
    $.get(url);
  });
  $("#new_buy").submit(function(e){
    var confirm_code = $.trim($("#buy_confirm_code").val());
    var password = $.trim($("#password").val());
    //if (confirm_code == '' || password == '') {
    if (password == '') {
      e.preventDefault();
    }
  });
});
