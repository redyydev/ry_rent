var cache = {
  currentVehicle: null,
  currentColor: null,
  currentColorR: null,
  currentColorG: null,
  currentColorB: null,
  maxPerformance: 0,
  totalPrice: 0
}

timeleft = 0

function openMenu(vehicles, maxPerformance) {
  $(".ui").fadeIn();
  $(".showedVehicle").hide()
  $(".rentalVehicles").html("")
  $(".rentalMenu").show()

  cache.maxPerformance = maxPerformance
  $("#maxperformance").html(`Max Performance - ${maxPerformance}${Config.Currency}`)
  $("#checked").prop("checked", false);

  cache.currentVehicle = null
  cache.currentColor = null
  cache.currentColorR = null
  cache.currentColorG = null
  cache.currentColorB = null

  if (!cache.currentVehicle)
  $("#noVehicle").fadeIn()

  vehicles.forEach(function(vehicle) {
    $(".rentalVehicles").append(`
      <div class="vehicle" id="vehicle-${vehicle.vehicleID}">
        <div class="header">
            <div class="header-title">${vehicle.vehicleLabel}</div>
            <div class="header-description">${vehicle.vehicleDescription}</div>
        </div>
        <div class="image">
            <img src="assets/${vehicle.vehicleImageName}" alt="${vehicle.vehicleModel}">
        </div>
        <div class="footer">
            <div class="footer-type">${vehicle.vehicleType}</div>
            <div class="footer-price">${vehicle.vehicleRentalPrice}${Config.Currency}</div>
        </div>
      </div>
    `)

    $(`#vehicle-${vehicle.vehicleID}`).click(function(e) {
      $(".vehicle").css("opacity", "0.4")
      if (cache.currentVehicle) {
        $(`#vehicle-${cache.currentVehicle}`).css("border", "1px solid rgba(255, 255, 255, 0.0)")
        cache.currentVehicle = null
      }
      showVehicle(vehicle)
    })
  })
}

function showVehicle(vehicle) {
  var checkedValue = $('.maxperformance:checked').val();

  cache.currentVehicle = vehicle.vehicleID
  $(`#vehicle-${cache.currentVehicle}`).css("opacity", "1.0")

  $(`#vehicle-${cache.currentVehicle}`).css("border", "1px solid rgba(255, 255, 255, 1.0)")
  $("#checked").prop("checked", false)
  $("#noVehicle").hide()

  cache.currentColor = 4
  cache.currentColorR = 0
  cache.currentColorG = 0
  cache.currentColorB = 0

  cache.totalPrice = vehicle.vehicleRentalPrice

  $("#vehicle-title").html(vehicle.vehicleLabel)
  $(".vehicle-colors").html("")
  $(".vehicle-currentColor").html(`Current Vehicle Color: <div class="vehicle-color" style="background: rgb(${cache.currentColorR}, ${cache.currentColorG}, ${cache.currentColorB}); position: absolute; width: 20px; height: 20px; margin-left: 130px; margin-top: -17px"></div>`)
  $.each(Config.Colors, function(index, color) {
    $(".vehicle-colors").append(`
      <div class="vehicle-color" id="color-${color.name}" style="background: rgb(${color.r}, ${color.g}, ${color.b}"><div class="vehicle-color-price">${color.price >= 1 ? color.price + Config.Currency : 'Free' }</div></div>

    `)

    $(`#color-${color.name}`).click(function() {
      if (cache.currentColor)
      cache.totalPrice = cache.totalPrice - Config.Colors[cache.currentColor].price
      cache.currentColor = null

      cache.currentColor = index
      cache.currentColorR = color.r
      cache.currentColorG = color.g
      cache.currentColorB = color.b
      cache.totalPrice = cache.totalPrice + color.price

      $(".vehicle-currentColor").html(`Current Vehicle Color: <div class="vehicle-color" style="background: rgb(${cache.currentColorR}, ${cache.currentColorG}, ${cache.currentColorB}); position: absolute; width: 20px; height: 20px; margin-left: 130px; margin-top: -17px"></div>`)
      $(`#rent-${cache.currentVehicle}`).html(`Rent Vehicle (${cache.totalPrice}${Config.Currency})`)
    })
  })

  $("#vehicle-footer").html("")
  $("#vehicle-footer").append(`<button class="rent" id="rent-${cache.currentVehicle}">Rent Vehicle for ${cache.totalPrice}${Config.Currency}</button>`)

  $(`#rent-${cache.currentVehicle}`).click(function() {

    $.post('https://ry_rent/rentVehicle', JSON.stringify({
      vehicleID: cache.currentVehicle,
      vehicleRentalPrice: cache.totalPrice,
      vehicleColor: { r: cache.currentColorR, g: cache.currentColorG, b: cache.currentColorB },
      vehicleMaxPerformance: checkedValue
    }));
  })

  $(".showedVehicle").fadeIn()
}

function clickChecked() {
  var checkedValue = $('.maxperformance:checked').val();

  if (checkedValue == 'on') {
    cache.totalPrice = cache.totalPrice + cache.maxPerformance
  } else {
    cache.totalPrice = cache.totalPrice - cache.maxPerformance
  }
  $(`#rent-${cache.currentVehicle}`).html(`Rent Vehicle for ${cache.totalPrice}${Config.Currency}`)
}







































function showTimer(time) {
  $("#timer").html('')
  $(".ui").fadeIn();
  $(".rentalMenu").hide()
  $(".container-timer").fadeIn()
  
  timeleft = time
  timeFunction = setInterval(function(){

    if(timeleft <= 0){
      $("#timer").css("animation", 'none')
      $('.info').css('animation', 'none')
      $('.container-timer').fadeOut();
      clearInterval(timeFunction);
      $.post('https://ry_rent/finishRent', JSON.stringify({}));

    } else if (timeleft == 10) {
      $('.info').css('animation', 'alert 0.3s infinite')
      $('#timer').css('animation', 'alert 0.3s infinite')
    } else if (timeleft == 5) {
      $('.info').css('animation', 'alert 0.2s infinite')
      $('#timer').css('animation', 'alert 0.2s infinite')
    } 

    $('#timer').html(`${timeFormat(timeleft)} LEFT`)
    timeleft -= 1;

  }, 1000);
}

function hideTimerMenu() {
  $("#timer").html('')
  $('.container-timer').fadeOut();
  clearInterval(timeFunction);
  timeleft = 0
}

function timeFormat(duration) {
  const hrs = ~~(duration / 3600);
  const mins = ~~((duration % 3600) / 60);
  const secs = ~~duration % 60;

  let ret = "";

  if (hrs > 0) {
    ret += "" + hrs + ":" + (mins < 10 ? "0" : "");
  }

  ret += "" + mins + ":" + (secs < 10 ? "0" : "");
  ret += "" + secs;

  return ret;
}

function closeMenu() {
  $.post("http://ry_rent/CloseMenu", JSON.stringify({}));
}