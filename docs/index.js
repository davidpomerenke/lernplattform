var select = document.getElementById('submit')
var target = document.getElementById('target')
select.onclick = () => {
  target.value = ''
  window.getPlans()
    .then(result => {
      var modules = result.Physik.Gymnasium[12].Bayern.default
      window.getLinks().then(links => {
        var moduleLinks = modules
          .flatMap(m =>
            links.Physik
              .filter(l => l.themen.includes(m))
              .map(l => 
                `<div class="media text-muted pt-3">
                  <!--
                  <svg class="bd-placeholder-img mr-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg"
                    preserveAspectRatio="xMidYMid slice" focusable="false" role="img" aria-label="Placeholder: 32x32">
                    <title>Placeholder</title>
                    <rect width="100%" height="100%" fill="#007bff" /><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text>
                  </svg>
                  -->
                  <img class="bd-placeholder-img mr-2" src="pfeile.png" style="height: 64px">
                  <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                    ${l.typ}
                    <strong class="d-block text-gray-dark"><a href="${l.link}">${l.beschreibung}</a></strong>
                    ${l.themen.join(" — ")}
                  </p>
                </div>`)
              .join("\n"))
            .join("\n")
        var html = 
          `<h6 class="border-bottom border-gray pb-2 mb-0">Physik</h6>
          ${moduleLinks}
          <small class="d-block text-right mt-3">
            <a href="#">Alle Links</a>
          </small>`
        target.innerHTML += html
        target.style.visibility = "visible"
      })
    })
}
