function main_menu(vehicles){
  $(".ui").fadeIn();
  $(".vehicles").html("");
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

function closeMenu() {
  $.post("http://ry_rent/CloseUI", JSON.stringify({}));
}