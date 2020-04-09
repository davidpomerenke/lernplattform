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
          $.ajax(`api/links?bundesland=${daten.bundesland}&schulart=${daten.schulart}&klassenstufe=${daten.klassenstufe}`)
            .done(result => {
              $('#fach-auswählen').attr('hidden', false)
              $('#fach-auswählen div').html(result.map(a => a.fach).unique().sort().map(a =>
                `<button type="button" class="fach btn btn-outline-primary rounded-pill m-2 py-1 px-3">${a}</button>`))
              $('button.fach').on('click', function (e) { $(this).toggleClass('bg-primary text-light') })
              $('#speichern').attr('hidden', false)
              $('#speichern').on('click', e => {
                daten.fächer = $('button.fach.bg-primary').map(function () { return $(this).text() }).get()
                localStorage.setItem('daten', JSON.stringify(daten))
                $('#auswahl').attr('hidden', true)
                $('#gespeichert').attr('hidden', false)
                $('#bearbeiten').attr('hidden', false)
                zeigeLinksAn(result)
              })
            })
            .fail(error => console.log(error))
        })
      })
    })

    // Liste mit Links
    const zeigeLinksAn = links => {
      $('#physik .card-body').html(links.map(a => `
        <div class="col-12 col-sm-12 col-md-6 col-lg-4 col-xl-3 p-1">
          <div class="card" style="height: 100%;">
            <div class="card-body" style="position: relative;">
              <span class="badge badge-info">${a.art}</span>
              <h5 class="card-title">${a.titel}</h5>
              <p class="card-text">${a.beschreibung}</p>
              <small class="text-muted">
                <a href="${a.link}" target="_blank" class="stretched-link"></a>
                ${a.link.replace(/https?:\/\/(www\.)?/, '').replace(/\/.*/, '')} 
                <i class="fas fa-external-link-alt"></i>
                </a>
              </small>
            </div>
            <div class="card-footer d-flex justify-content-between">
              <i class="far fa-thumbs-up fa-flip-horizontal text-success"
                style="font-size: x-large; cursor: pointer;"></i>
              <b>${a.upvotes - a.downvotes}</b>
              <i class="far fa-thumbs-down text-danger" style="font-size: x-large; cursor: pointer;"></i>
            </div>
          </div>
        </div>`).join('\n'))
    }
    if (localStorage.getItem('daten')) {
      $('#bearbeiten').attr('hidden', false)
      const daten = JSON.parse(localStorage.getItem('daten'))
      $.ajax(`api/links?bundesland=${daten.bundesland}&schulart=${daten.schulart}&klassenstufe=${daten.klassenstufe}`)
        .done(result => {
          zeigeLinksAn(result)
        })
    } else {
      zeigeButtonsAn()
    }
    $('#bearbeiten').on('click', e => {
      $('#bearbeiten').attr('hidden', true)
      zeigeButtonsAn(JSON.parse(localStorage.getItem('daten')))
    })
    $('.fa-thumbs-up, .fa-thumbs-down').on('click', function () { console.log('al'); $(this).toggleClass('fas').toggleClass('far') })
    $('#lokale-daten-löschen').on('click', e => {
      localStorage.removeItem('daten')
      $('#lokale-daten-löschen').attr('hidden', true)
      $('#lokale-daten-gelöscht').attr('hidden', false)
      $('#seite-neu-laden').attr('hidden', false)
      $('#seite-neu-laden').on('click', e => location.reload())
    })
  }
})