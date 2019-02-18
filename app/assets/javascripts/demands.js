$(".demands").ready(function() {
  $("#js-demand-price").change(function() {
    var price = $(this).val();
    var count = $("#js-demand-count").val();
    if (price != null && count != null) {
      var total = (price * count).toFixed(2);
      $("#js-demand-pay").html(total);
    }
  });
  $("#js-demand-count").change(function() {
    var count = $(this).val();
    var price = $("#js-demand-price").val();
    if (price != null && count != null) {
      var total = (price * count).toFixed(2);
      $("#js-demand-pay").html(total);
    }
  });
});
