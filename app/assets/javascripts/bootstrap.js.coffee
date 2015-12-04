jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.notification-alert').animate({opacity:'0'}, 1500,  "linear", -> (
    $(".notification-alert").hide();
  ))
