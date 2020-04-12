// Generelle Funktionen zum Wiederverwenden
Array.prototype.unique = function () { return Array.from(new Set(this)) }
Array.prototype.schulartenSort = function () {
  return this.sort((a, b) => {
    const schularten = [
      'Grundschule',
      'Hauptschule',
      'Werkrealschule',
      'Realschule (Grundlegendes Niveau)',
      'Realschule (Mittleres Niveau)',
      'Gymnasium',
      'Gemeinschaftsschule (Grundlegendes Niveau)',
      'Gemeinschaftsschule (Mittleres Niveau)',
      'Gemeinschaftsschule (Erweitertes Niveau)',
    ]
    if (schularten.includes(a) && schularten.includes(b)) {
      return schularten.indexOf(a) - schularten.indexOf(b)
    } else {
      return 0
    }
  })
}
String.prototype.capitalise = function () { return this[0].toUpperCase() + this.slice(1) }

var auswahlOptionen = null;

// Formular zum Auswählen von Bundesland, Schulart, Klassenstufe, Kursen
const zeigeAuswahlOptionen = (auswahl) => {
  if (auswahlOptionen) {
    zeigeButtons(auswahlOptionen, auswahl)
  } else {
    $.ajax(`api/start`)
      .done(auswahlOptionen => zeigeButtons(auswahlOptionen, auswahl))
      .fail(fehler => console.log(fehler))
  }
}

const zeigeButtons = (auswahlOptionen, auswahl) => {
  $('#auswahl').attr('hidden', false)
  zeigeBundeslandButton(auswahlOptionen, auswahl)
  zeigeSchulartButton(auswahlOptionen, auswahl)
  zeigeKlassenstufenButtons(auswahlOptionen, auswahl)
  zeigeFächerButtons(auswahl)
  zeigeLinks(auswahl)
}

const zeigeBundeslandButton = (auswahlOptionen, auswahl) => {
  let optionenHtml = ''
  if (!auswahl || !('bundesland' in auswahl)) {
    optionenHtml += '<option hidden disabled selected>Bundesland</option>'
  }
  optionenHtml += auswahlOptionen.map(a => a.bundesland).unique().sort().map(a =>
    `<option ${auswahl && 'bundesland' in auswahl && a === auswahl.bundesland ? 'selected' : ''}>${a}</option>`).join('')
  $('#bundesland-auswählen select').html(optionenHtml)
  $('#bundesland-auswählen').attr('hidden', false)
  $('#bundesland-auswählen select').change(() => zeigeSchulartButton(auswahlOptionen,
    { ...auswahl, bundesland: $('#bundesland-auswählen option:selected').text() }))
}

const zeigeSchulartButton = (auswahlOptionen, auswahl) => {
  if (auswahl && 'bundesland' in auswahl) {
    let optionenHtml = ''
    if (!('schulart' in auswahl)) {
      optionenHtml += '<option hidden disabled selected>Schulart</option>'
    }
    optionenHtml += auswahlOptionen
      .filter(a => a.bundesland === auswahl.bundesland)
      .map(a => a.schulart).unique().schulartenSort().map(a =>
        `<option ${auswahl && 'schulart' in auswahl && a === auswahl.schulart ? 'selected' : ''}>${a}</option>`).join('')
    $('#schulart-auswählen select').html(optionenHtml)
    $('#schulart-auswählen').attr('hidden', false)
    $('#schulart-auswählen select').change(() => zeigeKlassenstufenButtons(auswahlOptionen,
      { ...auswahl, schulart: $('#schulart-auswählen option:selected').text() }))
  }
}

zeigeKlassenstufenButtons = (auswahlOptionen, auswahl) => {
  if (auswahl && 'bundesland' in auswahl && 'schulart' in auswahl) {
    optionenHtml = auswahlOptionen
      .filter(a => a.bundesland === auswahl.bundesland && a.schulart === auswahl.schulart)
      .map(a => a.klassenstufe).unique().sort((a, b) => a - b).map(a =>
        `<option ${auswahl && 'klassenstufen' in auswahl && auswahl.klassenstufen.includes(a) ? 'selected' : ''}>${a}</option>`).join('')
    $('#klassenstufen-auswählen select').html(optionenHtml)
    $('#klassenstufen-auswählen').attr('hidden', false)
    $('#klassenstufen-auswählen select').change(() => zeigeFächerButtons({
      ...auswahl,
      klassenstufen: $('#klassenstufen-auswählen option:selected')
        .map(function () { return $(this).text() }).get()
    }))
  }
}

const zeigeFächerButtons = (auswahl) => {
  if (auswahl && 'bundesland' in auswahl && 'schulart' in auswahl &&
    'klassenstufen' in auswahl && auswahl.klassenstufen.length > 0) {
    $.ajax(`api/fächer?bundesland=${auswahl.bundesland}&schulart=${auswahl.schulart}&klassenstufen=${auswahl.klassenstufen.join(';')}`)
      .done(fächer => {
        const fächerHtml = fächer.sort().map(a =>
          `<button type="button" class="fach btn btn-outline-primary rounded-pill m-2 py-1 px-3` +
            (auswahl && 'fächer' in auswahl && auswahl.fächer.includes(a.fach) ? ' bg-primary text-light' : '') +
            `">${a.fach}</button>`)
        $('#fach-auswählen div').html(fächerHtml)
        $('#fach-auswählen').attr('hidden', false)
        $('button.fach').on('click', function () {
          $(this).toggleClass('bg-primary text-light')
          if ($('button.fach.bg-primary').length > 0) {
            $('#speichern').attr('hidden', false)
          } else {
            $('#speichern').attr('hidden', true)
          }
        })
        $('#speichern').on('click', () => {
          auswahl.fächer = $('button.fach.bg-primary').map(function () { return $(this).text() }).get()
          localStorage.setItem('auswahl', JSON.stringify(auswahl))
          $('#auswahl').attr('hidden', true)
          $('#gespeichert').attr('hidden', false)
          $('#bearbeiten').attr('hidden', false)
          zeigeLinks(auswahl)
        })
      })
      .fail(fehler => console.log(fehler))
  }
}

const zeigeLinks = (auswahl) => {
  if (auswahl && 'bundesland' in auswahl && 'schulart' in auswahl && 'klassenstufen' in auswahl &&
    auswahl.klassenstufen.length > 0 && 'fächer' in auswahl && auswahl.fächer.length > 0) {
    $.ajax(`api/lehrplan?bundesland=${auswahl.bundesland}&schulart=${auswahl.schulart}` +
      `&klassenstufen=${auswahl.klassenstufen.join(';')}&fächer=${auswahl.fächer.join(';')}`)
      .done(lehrplan => {
        $('#links').html(
          lehrplan.map(a => a.fach).unique().sort().map(fach => kartenRahmenHtml(fach, lehrplan)))
        $('button.lehrplantitel').on('click', function () {
          return $(this).toggleClass('bg-primary text-light')
        })
      })
      .fail(fehler => console.log(fehler))
  }
}

const kartenHtml = material => `
  <div class= "col-12 col-sm-12 col-md-6 col-lg-4 col-xl-3 p-1">
    <div class="card" style="height: 100%;">
      <div class="card-body" style="position: relative;">
        <span class="badge badge-info">${material.art}</span>
        <h5 class="card-title">${material.titel}</h5>
        <p class="card-text">${material.beschreibung}</p>
        <small class="text-muted">
          <a href="${material.link}" target="_blank" class="stretched-link"></a>
          ${material.link.replace(/https?:\/\/(www\.)?/, '').replace(/\/.*/, '')}
          <i class="fas fa-external-link-alt"></i>
          </a>
        </small>
    </div>
    <div class="card-footer d-flex justify-content-between">
      <i class="far fa-thumbs-up fa-flip-horizontal text-success"
        style="font-size: x-large; cursor: pointer;"></i>
      <b>${material.upvotes - material.downvotes}</b>
      <i class="far fa-thumbs-down text-danger" style="font-size: x-large; cursor: pointer;"></i>
    </div>
    </div>
  </div>`

const kartenRahmenHtml = (fach, lehrplan) => {
  const titelListe = lehrplan.filter(a => a.fach === fach && a.titel).map(a =>
    `<button type="button" class="lehrplantitel btn btn-outline-primary rounded-pill m-1 p-0 px-3"><small>${a.titel}</small></button>`).join('')
  return `
  <div id = "${fach}" class="card my-2">
    <div class="card-header">
      <h4>${fach}</h4>
    </div>
    <div class="card-body row">
      <div class="p-1 d-flex flex-wrap">
        ${titelListe}
      </div>
    </div>
  </div>`
  // ${materialien.filter(a => a.fach === fach).map(material => kartenHtml(material)).join('')}
}

const auswahl = JSON.parse(localStorage.getItem('auswahl'))
if (auswahl && 'bundesland' in auswahl && 'schulart' in auswahl &&
  'klassenstufen' in auswahl && 'fächer' in auswahl) {
  $('#bearbeiten').attr('hidden', false)
  zeigeLinks(auswahl)
} else {
  zeigeAuswahlOptionen(auswahl)
}
$('#bearbeiten').on('click', () => {
  $('#bearbeiten').attr('hidden', true)
  zeigeAuswahlOptionen(JSON.parse(localStorage.getItem('auswahl')))
})
$('#lokale-daten-löschen').on('click', () => {
  localStorage.removeItem('daten')
  $('#lokale-daten-löschen').attr('hidden', true)
  $('#lokale-daten-gelöscht').attr('hidden', false)
  $('#seite-neu-laden').attr('hidden', false)
  $('#seite-neu-laden').on('click', e => location.reload())
})
$('.fa-thumbs-up, .fa-thumbs-down').on('click', function () { $(this).toggleClass('fas').toggleClass('far') })