var in_options = false

window.addEventListener("message", function (event) {
    if (event.data.action == "open") {
        main_menu(event.data.content.vehicles)
    } else if (event.data.action == 'close') {
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



