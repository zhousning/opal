$(".demands").ready(function() {
  $("#js-demand-price").change(function() {
    var price = $(this).val();
    var count = $("#js-demand-count").val();
    if (price != null && count != null) {
      $("#js-demand-pay").html(price * count);
    }
  });
  $("#js-demand-count").change(function() {
    var count = $(this).val();
    var price = $("#js-demand-price").val();
    if (price != null && count != null) {
      $("#js-demand-pay").html(price * count);
    }
  });
});
