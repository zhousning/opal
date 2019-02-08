$(".sells").ready(function() {
  $("#js-sell-price").change(function() {
    var price = $(this).val();
    var count = $("#js-sell-count").val();
    if (price != null && count != null) {
      $("#js-sell-poundage").html(price * count * 0.1);
    }
  });
  $("#js-sell-count").change(function() {
    var count = $(this).val();
    var price = $("#js-sell-price").val();
    if (price != null && count != null) {
      $("#js-sell-poundage").html(price * count * 0.1);
    }
  });

});
