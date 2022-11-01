var options = {
  vehicle_color: {
    color: null,
    price: null
  },
  current_vehicle: {
    name: null,
    r: 0,
    g: 0,
    b: 0
  }
}

function main_menu(vehicles){
  $(".ui").fadeIn();
  $(".options").hide();

  options.vehicle_color.color = null
  options.current_vehicle.name = null

  $(".container-timer").css('display', 'none')
  $(".vehicles").css('display', 'block');
  $(".vehicles").html('');

  $.each(vehicles, function(index, vehicle) {
    $(".vehicles").append(`
    <div class="vehicle" id="vehicle-${vehicle.id}">
      <div class="header">
          <div class="header-title">${vehicle.label}</div>
          <div class="header-description">${vehicle.description}</div>
      </div>
      <div class="image">
          <img src="assets/${vehicle.image}" alt="${vehicle.model}">
      </div>
      <div class="footer">
          <div class="footer-type">${vehicle.type}</div>
          <div class="footer-price">${vehicle.price}${Config.Currency}</div>
      </div>
    </div>
    `);

    
    $(`#vehicle-${vehicle.id}`).click(function () {
      if (options.current_vehicle.name) {
        $(`#vehicle-${options.current_vehicle.name}`).css("border", "1px solid rgba(255, 255, 255, 0)")
        $(`#color-${options.vehicle_color.color}`).css("border", "1px solid rgba(255, 255, 255, 0)")
    
        options.vehicle_color.color = null
        options.current_vehicle.name = null
        ChooseOptions(vehicle, false)
      } else {
        options.current_vehicle.name = vehicle.id
        $(`#vehicle-${vehicle.id}`).css("border", "1px solid rgba(255, 255, 255, 0.5)")
        ChooseOptions(vehicle, true)
      }
    })

  })
}

function ChooseOptions(vehicle, inoptions) {
  var total = vehicle.price;

  if (inoptions) {
    $(".colors").html("")
    $(".options").show();

    $(".colors").append(`
    <div class="option-exit" id="exit"><i class="bi bi-x-circle"></i></div>`)

    $("#exit").click(function () {
      $(".options").hide();

      $(`#vehicle-${options.current_vehicle.name}`).css("border", "1px solid rgba(255, 255, 255, 0)")
        options.current_vehicle.name = null
    })
  
      $.each(Config.Colors, function(index, color) {
        $(".colors").append(`
            <div class="option-color" id="color-${color.name}" style="background: rgb(${color.r}, ${color.g}, ${color.b})"></div>
        `)
    
        $(`#color-${color.name}`).click(function () {
          if (options.vehicle_color.color) {
            $(`#color-${options.vehicle_color.color}`).css("opacity", "0.5")
            $(`#color-${color.name}`).css("box-shadow", `2px 5px 10px 0 rgba(0, 0, 0, 0.2)`)
    
            options.vehicle_color.color = null
            total = vehicle.price 
            $("#total").html(`Rent (${total}$)`)
          } else {
            options.vehicle_color.color = color.name;
            options.vehicle_color.price = color.price;

            options.current_vehicle.r = color.r;
            options.current_vehicle.g = color.g;
            options.current_vehicle.b = color.b;

            total = vehicle.price + color.price
    
            $("#total").html(`Rent (${total}$)`)
            $(`#color-${color.name}`).css("opacity", "1.0")
            $(`#color-${color.name}`).css("box-shadow", `0px 0px 15px 0 rgb(${color.r}, ${color.g}, ${color.b})`)
          }
        });
      });
  
    $(".buttons").html(`<button id="total">Rent (${total}$)</button>`)

    $("#total").click(function () {
        if (options.vehicle_color.color) {
        $.post('https://ry_rent/rent', JSON.stringify({
          model: vehicle.model,
          price: total,
          location: vehicle.location,
          r: options.current_vehicle.r,
          g: options.current_vehicle.g,
          b: options.current_vehicle.b
         }));
        }
      })
  } else {
    $(".options").hide();
  }
  
}

function timer_menu(time){
  $(".ui").fadeIn();
  $("#timer").html('')

  $(".vehicles").css('display', 'none')
  $(".options").css('display', 'none')
  $(".container-timer").css('display', 'block')

  timeleft = time

  time_function = setInterval(function(){

    if(timeleft <= 0){
      $("#timer").css("animation", 'none')
      $('.info').css('animation', 'none')
      $('.container-timer').fadeOut();
      clearInterval(time_function);
      $.post('https://ry_rent/finishRent', JSON.stringify({}));

    } else if (timeleft == 10) {
      $('.info').css('animation', 'alert 0.3s infinite')
      $('#timer').css('animation', 'alert 0.3s infinite')
    } else if (timeleft == 5) {
      $('.info').css('animation', 'alert 0.2s infinite')
      $('#timer').css('animation', 'alert 0.2s infinite')
    } 

    $('#timer').html(`${timeleft} seconds LEFT`)
    timeleft -= 1;

  }, 1000);
}

function hide_timer_menu(){
  $("#timer").html('')
  $('.container-timer').fadeOut();
  clearInterval(time_function);
  timeleft = 0
} 

function notification(text) {
    $(".notification").fadeIn();
    $(".notification").css("right", "15%");
    $(".notification").html(`<i class="bi bi-bell"></i> ${text}`);
    setTimeout(function() {
      $(".notification").fadeOut();
  }, 2000)
}

function closeMenu() {
  $.post("http://ry_rent/CloseUI", JSON.stringify({}));
}