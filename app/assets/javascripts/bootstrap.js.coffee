jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.notification-alert').delay(2000).animate({opacity:'0'}, 3500,  "linear", -> (
    $(".notification-alert").hide();
  ))
