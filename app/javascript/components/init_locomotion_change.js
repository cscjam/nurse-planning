import { map } from 'jquery';
import { refreshMapboxes }  from './init_mapbox.js'

const getPrettyInfos = (journey) => {
  let mins = journey["duration"];
  let hours = Math.trunc(mins / 60)
  let duration = "";
  if ( hours > 0){
    duration += `${hours}h`;
  }
  duration += `${Math.trunc(mins % 60)}min`;
  let specificJourney = "";
  // if(null != journey["start_user_id"]){
  //   specificJourney = "depuis domicile "
  // }
  // if(null != journey["end_user_id"]){
  //   specificJourney = "vers domicile "
  // }
  return "Trajet " + specificJourney + ": " + duration + " - " + journey["distance"] + "m";
}

const updateJourneysCards = (journeysJson) => {
  if(journeysJson) {
    for(let index = 0; index < journeysJson.length; index++){
      const journeyElt = document.querySelector(`#journey-${index} .card-journey-info p`);
      if(journeyElt) {
        let chevronIcon = "";
        let test = journeyElt.innerHTML;
        const chevronIndex = journeyElt.innerHTML.indexOf("<");
        if(chevronIndex != -1) {
          chevronIcon = journeyElt.innerHTML.substr(chevronIndex);
        }
        chevronIcon = journeyElt.innerHTML.substr(chevronIndex);
        journeyElt.innerHTML = getPrettyInfos(journeysJson[index]) + chevronIcon;
      }
    };
  };
};

const updateMapElts = (journeysJson) => {
  if(journeysJson) {
    for(let index = 0; index < journeysJson.length; index++){
      const mapElt = document.querySelector(`#map-${index}`);
      if(mapElt) {
        mapElt.dataset.journeyId = journeysJson[index]["id"];
      }
    }
  }
}

export const initLocomotionChange = () => {
  const locomotionElt = document.getElementById("locomotion");
  if (locomotionElt) {
    locomotionElt.addEventListener("change", event => {
      let url = `/visits?locomotion=${locomotionElt.value}`
      fetch(url, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        updateJourneysCards(data["journeys"]);
        updateMapElts(data["journeys"]);
        refreshMapboxes();
      });
    });
  }
};
