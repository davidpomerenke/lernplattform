// Formular zum Auswählen von Bundesland, Schulart, Klassenstufe, Kursen
// $('#bundesland-auswählen').on('hidden.bs.dropdown', () => console.log('selected'))
$('#bundesland-auswählen a').on('click', (e) => {
  const bundesland = e.target.innerText
  localStorage.setItem('bundesland', bundesland)
  $('#bundesland-auswählen button').text(bundesland)
  $('#schulart-auswählen').attr('hidden', false)
  $.get(`https://lernplattform-api.heroku.com?bundesland=${bundesland}`, data => {
    console.log(data)
  }, 'json')
})