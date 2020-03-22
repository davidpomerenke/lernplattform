var select = document.getElementById('submit')
var target = document.getElementById('target')
select.onclick = () => {
  target.value = ''
  window.getPlans()
    .then(result => {
      target.innerHTML += JSON.stringify(result)
    })
}
