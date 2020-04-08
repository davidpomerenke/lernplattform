// Generelle Funktionen zum Wiederverwenden
Array.prototype.unique = function () { return Array.from(new Set(this)) }
String.prototype.capitalise = function () { return this[0].toUpperCase() + this.slice(1) }

// Formular zum Auswählen von Bundesland, Schulart, Klassenstufe, Kursen
$.ajax({
  url: `api/start`,
  success: ergebnis => {
    const zeigeButtonAn = (feld, daten, callback) => {
      $(`#${feld}-auswählen`).attr('hidden', false)
      $(`#${feld}-auswählen select`).html(
        `<option hidden disabled selected>${feld.capitalise()}</option>` +
        ergebnis
          .filter(a => Object.keys(daten).map(b => a[b] === daten[b]))
          .map(a => a[feld])
          .unique()
          .sort()
          .map(a => `<option>${a}</option>`).join('\n'))
      $(`#${feld}-auswählen select`).change(e =>
        callback({ ...daten, [feld]: $(`#${feld}-auswählen option:selected`).text() }))
    }
    const zeigeButtonsAn = daten => zeigeButtonAn('bundesland', {}, daten => {
      $('#klassenstufe-auswählen, #fächer-auswählen').attr('hidden', true)
      zeigeButtonAn('schulart', daten, daten => {
        $('#fach-auswählen').attr('hidden', true)
        zeigeButtonAn('klassenstufe', daten, daten => {
          $.ajax({
            url: `api/fach?bundesland=${daten.bundesland}&schulart=${daten.schulart}&klassenstufe=${daten.klassenstufe}`,
            success: result => {
              $('#fach-auswählen').attr('hidden', false)
              $('#fach-auswählen div').html(result.map(a =>
                `<button type="button" class="fach btn btn-outline-primary rounded-pill m-2 py-1 px-3">${a.fach}</button>`))
              $('button.fach').on('click', function (e) { $(this).toggleClass('bg-primary text-light') })
              $('#speichern').attr('hidden', false)
              $('#speichern').on('click', e => {
                daten.fächer = $('button.fach.bg-primary').map(function () { return $(this).text() }).get()
                localStorage.setItem('daten', daten)
                $('#auswahl').attr('hidden', true)
                $('#gespeichert').attr('hidden', false)
                $('#bearbeiten').attr('hidden', false)
              })
            }
          })
        })
      })
    })
    if (localStorage.getItem('daten')) {
      $('#bearbeiten').attr('hidden', false)
    } else {
      zeigeButtonsAn()
    }
    $('#bearbeiten').on('click', e => {
      $('#bearbeiten').attr('hidden', true)
      zeigeButtonsAn(localStorage.getItem('daten'))
    })
    $('.fa-thumbs-up, .fa-thumbs-down').on('click', function() {$(this).toggleClass('fas').toggleClass('far')})
  }
})