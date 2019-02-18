$(".sells").ready(function() {
  $("#js-sell-price").change(function() {
    var price = $(this).val();
    var count = $("#js-sell-count").val();
    if (price != null && count != null) {
      var total = (price * count * 0.1).toFixed(2); 
      $("#js-sell-poundage").html(total);
    }
  });
  $("#js-sell-count").change(function() {
    var count = $(this).val();
    var price = $("#js-sell-price").val();
    if (price != null && count != null) {
      var total = (price * count * 0.1).toFixed(2); 
      $("#js-sell-poundage").html(total);
    }
  });

});
