export const getPlans = () =>
  import(`./lehrpläne.json`)
    .then(({ default: data }) => {
      return data
    })
export const getLinks = () =>
  import(`./links.json`)
    .then(({ default: data }) => {
      return data
    })