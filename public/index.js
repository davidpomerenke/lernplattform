// Generelle Funktionen zum Wiederverwenden
Array.prototype.unique = function () {
  return Array.from(new Set(this))
}
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
      'Gemeinschaftsschule (Erweitertes Niveau)'
    ]
    if (schularten.includes(a) && schularten.includes(b)) {
      return schularten.indexOf(a) - schularten.indexOf(b)
    } else {
      return 0
    }
  })
}
String.prototype.capitalise = function () {
  return this[0].toUpperCase() + this.slice(1)
}

var auswahlOptionen = null

// Formular zum Auswählen von Bundesland, Schulart, Klassenstufe, Kursen
const zeigeAuswahlOptionen = auswahl => {
  if (auswahlOptionen) {
    zeigeButtons(auswahlOptionen, auswahl)
  } else {
    $.ajax('api/start')
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
  zeigeSpeichernButton(auswahl)
}

const zeigeBundeslandButton = (auswahlOptionen, auswahl) => {
  let optionenHtml = ''
  if (!auswahl || !('bundesland' in auswahl)) {
    optionenHtml += '<option hidden disabled selected>Bundesland</option>'
  }
  optionenHtml += auswahlOptionen
    .map(a => a.bundesland)
    .unique()
    .sort()
    .map(
      a =>
        `<option ` +
        (auswahl && 'bundesland' in auswahl && a === auswahl.bundesland
          ? 'selected'
          : '') +
        `>${a}</option>`
    )
    .join('')
  $('#bundesland-auswählen select').html(optionenHtml)
  $('#bundesland-auswählen').attr('hidden', false)
  $('#bundesland-auswählen select').change(() => {
    auswahl = {
      ...auswahl,
      bundesland: $('#bundesland-auswählen option:selected').text()
    }
    zeigeSchulartButton(auswahlOptionen, auswahl)
    zeigeKlassenstufenButtons(auswahlOptionen, auswahl)
    zeigeFächerButtons(auswahlOptionen, auswahl)
    zeigeSpeichernButton(auswahl)
  })
}

const zeigeSchulartButton = (auswahlOptionen, auswahl) => {
  if (auswahl && 'bundesland' in auswahl) {
    let optionenHtml = ''
    if (!('schulart' in auswahl)) {
      optionenHtml += '<option hidden disabled selected>Schulart</option>'
    }
    optionenHtml += auswahlOptionen
      .filter(a => a.bundesland === auswahl.bundesland)
      .map(a => a.schulart)
      .unique()
      .schulartenSort()
      .map(
        a =>
          '<option ' +
          (auswahl && 'schulart' in auswahl && a === auswahl.schulart
            ? 'selected'
            : '') +
          `>${a}</option>`
      )
      .join('')
    $('#schulart-auswählen select').html(optionenHtml)
    $('#schulart-auswählen').attr('hidden', false)
    $('#schulart-auswählen select').change(() => {
      auswahl = {
        ...auswahl,
        schulart: $('#schulart-auswählen option:selected').text()
      }
      zeigeKlassenstufenButtons(auswahlOptionen, auswahl)
      zeigeFächerButtons(auswahlOptionen, auswahl)
      zeigeSpeichernButton(auswahl)
    })
  }
}

zeigeKlassenstufenButtons = (auswahlOptionen, auswahl) => {
  if (auswahl && 'bundesland' in auswahl && 'schulart' in auswahl) {
    optionenHtml = auswahlOptionen
      .filter(
        a =>
          a.bundesland === auswahl.bundesland && a.schulart === auswahl.schulart
      )
      .map(a => a.klassenstufe)
      .unique()
      .sort((a, b) => a - b)
      .map(
        a =>
          '<button type="button" class="klassenstufe btn btn-light border border-primary text-primary' +
          (auswahl &&
          'klassenstufen' in auswahl &&
          auswahl.klassenstufen.includes(a)
            ? ' bg-primary text-light'
            : '') +
          `">${a}</button>`
      )
      .join('')
    $('#klassenstufen-auswählen div').html(optionenHtml)
    $('#klassenstufen-auswählen').attr('hidden', false)
    $('button.klassenstufe').on('click', function () {
      $(this).toggleClass('bg-primary text-light')
      auswahl = {
        ...auswahl,
        klassenstufen: $('button.klassenstufe.bg-primary')
          .map(function () {
            return $(this).text()
          })
          .get()
          .map(a => parseInt(a))
      }
      zeigeFächerButtons(auswahl)
      zeigeSpeichernButton(auswahl)
    })
  }
}

const zeigeFächerButtons = auswahl => {
  if (
    auswahl &&
    'bundesland' in auswahl &&
    'schulart' in auswahl &&
    'klassenstufen' in auswahl &&
    auswahl.klassenstufen.length > 0
  ) {
    $.ajax(
      `api/fächer?bundesland=${auswahl.bundesland}&schulart=${auswahl.schulart}&` +
        `klassenstufen=${JSON.stringify(auswahl.klassenstufen)}`
    )
      .done(fächer => {
        const fächerHtml = auswahl.klassenstufen
          .map(
            klassenstufe =>
              (auswahl.klassenstufen.length > 1
                ? `<h5>${klassenstufe}. Klasse</h5>`
                : '') +
              `<div class="fach ${klassenstufe}` +
              (auswahl.klassenstufen.length > 1
                ? ' border rounded-lg bg-light my-2">'
                : '">') +
              fächer
                .filter(a => a.klassenstufe === klassenstufe)
                .map(a => a.fach)
                .sort()
                .map(
                  fach =>
                    '<button type="button" class="fach btn btn-outline-primary rounded-pill m-2 py-1 px-3' +
                    (auswahl &&
                    'fächer' in auswahl &&
                    auswahl.fächer.find(
                      b => b.fach === fach && b.klassenstufe === klassenstufe
                    )
                      ? ' bg-primary text-light'
                      : '') +
                    `">${fach}</button>`
                )
                .join('') +
              '</div>'
          )
          .join('')
        $('#fach-auswählen div').html(fächerHtml)
        $('#fach-auswählen').attr('hidden', false)
        $('button.fach').on('click', function () {
          $(this).toggleClass('bg-primary text-light')
          zeigeSpeichernButton(auswahl)
        })
      })
      .fail(fehler => console.log(fehler))
  } else {
    $('#fach-auswählen').attr('hidden', true)
  }
}

const zeigeSpeichernButton = auswahl => {
  if (auswahl && 'klassenstufen' in auswahl) {
    const fächer = auswahl.klassenstufen.flatMap(klassenstufe =>
      $(
        `#fach-auswählen:not([hidden]) .fach.${klassenstufe} button.fach.bg-primary:not([hidden])`
      )
        .map(function () {
          return { klassenstufe: klassenstufe, fach: $(this).text() }
        })
        .get()
    )
    if (fächer.length > 0) {
      $('#speichern').attr('hidden', false)
      $('#speichern').on('click', () => {
        auswahl.fächer = fächer
        localStorage.setItem('auswahl', JSON.stringify(auswahl))
        $('#auswahl').attr('hidden', true)
        $('#gespeichert').attr('hidden', false)
        $('#bearbeiten').attr('hidden', false)
        zeigeLehrpläne(auswahl)
      })
    } else {
      $('#speichern').attr('hidden', true)
    }
  }
}

const zeigeLehrpläne = auswahl => {
  if (
    auswahl &&
    'bundesland' in auswahl &&
    'schulart' in auswahl &&
    'klassenstufen' in auswahl &&
    auswahl.klassenstufen.length > 0 &&
    'fächer' in auswahl &&
    auswahl.fächer.length > 0
  ) {
    $.ajax(
      `api/lehrplan?bundesland=${auswahl.bundesland}&` +
        `schulart=${auswahl.schulart}&fächer=` +
        JSON.stringify(auswahl.fächer)
    )
      .done(lehrplan => {
        const lehrplanHtml = auswahl.klassenstufen
          .map(klassenstufe =>
            lehrplan
              .filter(a => a.klassenstufe === klassenstufe)
              .map(a => a.fach)
              .unique()
              .sort()
              .map(fach =>
                kartenRahmenHtml(
                  klassenstufe,
                  fach,
                  lehrplan,
                  auswahl.klassenstufen.length > 1
                )
              )
              .join('')
          )
          .join('')
        $('#links').html(lehrplanHtml)
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
            ${material.link
              .replace(/https?:\/\/(www\.)?/, '')
              .replace(/\/.*/, '')}
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

const kartenRahmenHtml = (
  klassenstufe,
  fach,
  lehrplan,
  klassenstufeImTitel
) => {
  const titelListe = lehrplan
    .filter(a => a.klassenstufe === klassenstufe && a.fach === fach && a.titel)
    .map(
      a => `
    <button type="button" class="lehrplantitel btn btn-outline-primary rounded-pill m-1 p-0 px-3">
      <small>${a.titel}</small>
    </button>`
    )
    .join('')
  return `
  <div id = "${fach}" class="card my-2">
    <div class="card-header">
      <h4>${
        (klassenstufeImTitel ? klassenstufe + '. Klasse: ' : '') + fach
      }</h4>
    </div>
    <div class="card-body row">
      <div class="p-1 d-flex flex-wrap">
        ${titelListe}
      </div>
    </div>
  </div>`
}

const auswahl = JSON.parse(localStorage.getItem('auswahl'))
if (
  auswahl &&
  'bundesland' in auswahl &&
  'schulart' in auswahl &&
  'klassenstufen' in auswahl &&
  'fächer' in auswahl
) {
  $('#bearbeiten').attr('hidden', false)
  zeigeLehrpläne(auswahl)
} else {
  zeigeAuswahlOptionen(auswahl)
}

$('#bearbeiten').on('click', () => {
  $('#gespeichert').attr('hidden', true)
  $('#bearbeiten').attr('hidden', true)
  zeigeAuswahlOptionen(JSON.parse(localStorage.getItem('auswahl')))
})

$('#lokale-daten-löschen').on('click', () => {
  localStorage.removeItem('auswahl')
  localStorage.removeItem('entwicklungswarnung-ausblenden')
  $('#lokale-daten-löschen').attr('hidden', true)
  $('#lokale-daten-gelöscht').attr('hidden', false)
  $('#seite-neu-laden').attr('hidden', false)
  $('#seite-neu-laden').on('click', () => location.reload())
})

$('.fa-thumbs-up, .fa-thumbs-down').on('click', function () {
  $(this).toggleClass('fas').toggleClass('far')
})

if (!localStorage.getItem('entwicklungswarnung-ausblenden')) {
  $('#entwicklungswarnung').attr('hidden', false)
}
$('#entwicklungswarnung button.close').on('click', () => {
  $('#entwicklungswarnung').attr('hidden', true)
  localStorage.setItem('entwicklungswarnung-ausblenden', 'true')
})
