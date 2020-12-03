import { updateJourneysCards, updateMapElts}  from './init_mapbox.js'

export const initLocomotionChange = () => {
  const locomotionElt = document.getElementById("locomotion");
  if (locomotionElt) {
    locomotionElt.addEventListener("change", event => {
      let url = `/visits?locomotion=${locomotionElt.value}`
      fetch(url, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        updateJourneysCards(data);
        updateMapElts(data);
      });
    });
  }
};
