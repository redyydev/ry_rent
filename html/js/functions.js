var timeleft = 0;
var time_function = null

function main_menu(vehicles){
  $(".ui").fadeIn();
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
          <img src="assets/${vehicle.image}.png" alt="${vehicle.model}">
      </div>
      <div class="footer">
          <div class="footer-type">${vehicle.type}</div>
          <div class="footer-price">${vehicle.price}${Config.Currency}</div>
      </div>
    </div>
    `);

    $(`#vehicle-${vehicle.id}`).click(function () {
      $.post('https://ry_rent/rent', JSON.stringify({
          model: vehicle.model,
          price: vehicle.price,
          location: vehicle.location
      }));
      closeMenu()
    })

  })

}

function timer_menu(time){
  $(".ui").fadeIn();

  $(".vehicles").css('display', 'none')
  $(".container-timer").css('display', 'block')

  $("#timer").html('')

  timeleft = time

  time_function = setInterval(function(){

  if(timeleft <= 0){
    $("#timer").css("animation", 'none')
    $('.info').css('animation', 'none')
    $('.container-timer').fadeOut();
    clearInterval(time_function);
    $.post('https://ry_rent/finish', JSON.stringify({}));

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

function closeMenu() {
  $.post("http://ry_rent/CloseUI", JSON.stringify({}));
}