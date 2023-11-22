window.addEventListener("message", function (event) {
    var action = event.data.action
    var data = event.data.data
  
    if (action == "openMenu") {
      openMenu(data.rentalVehicles, data.maxPerformance)
    } else if (action == "showTimer") {
      showTimer(data.time)
    } else if (action == "hideTimer") {
      hideTimerMenu();
    } else if (action == "closeMenu") {
      $(".ui").fadeOut();
    }
  });
  
  $(document).ready(function () {
    $("body").on("keyup", function (key) {
      if (Config.closeKeys.includes(key.which)) {
        closeMenu();
      }
  });
});
