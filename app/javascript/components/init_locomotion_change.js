import { updateJourneysAbstractAndMaps, getMap, createMap, addGeometryJson }  from './init_mapbox.js'

export const initLocomotionChange = () => {
  const locomotionElt = document.getElementById("locomotion");
  if (locomotionElt) {
    locomotionElt.addEventListener("change", event => {
      let url = `/visits?locomotion=${locomotionElt.value}`
      fetch(url, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        const mapElts = updateJourneysAbstractAndMaps(data);
        if(mapElts) {
          mapElts.forEach((mapElt)=> {
            const mapGui = getMap(mapElt);
            if(mapGui) {
              addGeometryJson(mapGui, mapElt);
            } else {
              createMap(mapElt)
            }
          })
        }
      });
    });
  }
};
