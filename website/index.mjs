// Formular zum Auswählen von Bundesland, Schulart, Klassenstufe, Kursen
$('#bundesland-auswählen a').on('click', (e) => {
  const bundesland = e.target.innerText
  localStorage.setItem('bundesland', bundesland)
  $('#bundesland-auswählen button').text(bundesland)
  $('#schulart-auswählen').attr('hidden', false)
  $.ajax({
    url: `https://lernplattform-api.heroku.com?bundesland=${bundesland}`,
    success: result => {
      console.log(result)
      $('#schulart-auswählen .dropdown-menu')
        .html(result.map(schulart => `<a class="dropdown-item" href="#">${schulart}`).join('\n'))
    }
  })
})