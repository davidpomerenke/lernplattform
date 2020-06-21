// Materialien (pro Klassenstufe, Fach)
const zeigeMaterialien = auswahl => {
  if (
    auswahl &&
    'bundesland' in auswahl &&
    'schulart' in auswahl &&
    'klassenstufen' in auswahl &&
    auswahl.klassenstufen.length > 0 &&
    'fächer' in auswahl &&
    auswahl.fächer.length > 0
  ) {
    const _zeigeLehrpläne = (lehrplanDaten, materialDaten) => {
      $('#links').html(
        auswahl.fächer
          .map(a =>
            kartenRahmenHtml(
              a.klassenstufe,
              a.fach,
              auswahl.klassenstufen.length > 1,
              lehrplanDaten
            )
          )
          .join('')
      )
      $('button.lehrplantitel').on('click', function () {
        return $(this).toggleClass('bg-primary text-light')
      })
    }
    $.ajax(
      `api/lehrplan?bundesland=${auswahl.bundesland}&schulart=${auswahl.schulart}&fächer=` +
        JSON.stringify(auswahl.fächer)
    )
      .done(lehrplanDaten => _zeigeLehrpläne(lehrplanDaten))
      .fail(fehler => console.log(fehler))
  }
}

// Materialien (pro Fach)
const kartenRahmenHtml = (
  klassenstufe,
  fach,
  klassenstufeImTitel,
  lehrplanDaten
) => {
  const titelListe = lehrplanDaten
    .filter(a => a.klassenstufe === klassenstufe && a.fach === fach && a.titel)
    .map(a => a.titel)
    .unique()
    .map(titel => {
      const hierarchie = lehrplanDaten.find(a => a.titel === titel).hierarchie
      return `
        <button 
          type="button" 
          id="hierarchie-${hierarchie}"
          class="lehrplantitel btn btn-outline-primary rounded-pill m-1 p-0 px-3 abs
            hierarchie-${hierarchie}"
        >
          <small>${titel}</small>
        </button>`
    })
    .join('')
  const karten = lehrplanDaten
    .filter(
      a => a.link != null && a.fach === fach && a.klassenstufe === klassenstufe
    )
    .map(a => a.link)
    .unique()
    .map(link => kartenHtml(lehrplanDaten.find(a => a.link === link)))
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
      <div class="p-1 d-flex flex-wrap">
        ${karten}
      </div>
    </div>
  </div>`
}

// Einzelnes Material
const kartenHtml = material => `
  <div class= "col-12 col-sm-12 col-md-6 col-lg-4 col-xl-3 p-1">
    <div class="card" style="height: 100%;">
      <div class="card-body" style="position: relative;">
        <span class="badge badge-info">${material.materialart}</span>
        <h5 class="card-title">${material.materialtitel}</h5>
        <p class="card-text">${material.materialbeschreibung}</p>
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

