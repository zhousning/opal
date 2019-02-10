$(".tasks").ready(function(){
  $('#invite-copy-btn').popover({placement:'bottom', content:'复制成功', trigger:"focus", delay: {"show": 100, "hide": 3000 }});
  var invite_clipboard = new Clipboard('#invite-copy-btn', {
    text: function(trigger){
      var message = "茶叶区块链"
      var link = $("#invite_link").val();
      return message + link
    }
  });
  invite_clipboard.on('success', function(e){
    $('#invite-copy-btn').popover('show');
  });
});
