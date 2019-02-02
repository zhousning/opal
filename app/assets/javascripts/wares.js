$(".wares").ready(function() {
  //var K = window.KindEditor;
  //var options = {
  //  width:'100%',
  //  height:500,
  //  allowFileManager : true,
  //  uploadJson : "/kindeditor/upload",
  //  fileManagerJson : "/kindeditor/filemanager",
  //  themeType : 'editor'
  //}
  //var kindeditor = K.create("#kindeditor-wares-content",options);

  //使用kindediter的sync函数更安全
  //var url = "";
  //var isEditor = false;
  //if ($("body.wares").length > 0) {
  //  url = "http://"+window.location.host+"/wares/"+gon.wareId+"/mainbodies/"+gon.chapterNumber;
  //  isEditor = true;
  //}
  //if (isEditor) {
  //  window.onbeforeunload = function() {
  //    kindeditor.sync();
  //    var content = $("form").serialize();
  //    //必须使用同步调用，异步调用有时会失败，使用async:false
  //    $.ajax({
  //      type: "PUT",
  //      async: false,
  //      url: url,
  //      data: content,
  //      dataType: "json"
  //    });
  //  }
  //}
});
