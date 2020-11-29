const getPrettyInfos = (journey) => {
  let mins = journey["duration"];
  let hours = mins / 60
  let duration = "";
  if ( hours > 0){
    duration += `${hours}h`;
  }
  duration += `${mins % 60}m`;
  let specificJourney = "";
  if(null != journey["start_user_id"]){
    specificJourney = "depuis domicile "
  }
  if(null != journey["end_user_id"]){
    specificJourney = "vers domicile "
  }
  return "Trajet " + specificJourney + ": " duration + " - " + journey["distance"];
}

const updateJourneysCards = (journeysJson) => {
  console.log(journeysJson)
  if(journeysJson) {
    journeysJson.forEach(journeyJson => {
      console.log(`journey-${journeyJson["id"]}`)
      const journeyElt = document.getElementById(`journey-${journeyJson["id"]}`);
      console.log(journeyElt);
      if(journeyElt) {
        journeyElt.innerText = getPrettyInfos(journeyJson)
      }
    });
  };
};

export const initJourneyChange = () => {
  const locomotionElt = document.getElementById("locomotion");
  if (locomotionElt) {
    locomotionElt.addEventListener("change", event => {
      console.debug(`Transport=${locomotionElt.value}`)
      let url = `/visits?locomotion=${locomotionElt.value}`
      fetch(url, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        updateJourneysCards(data["journeys"])
      });
    });
  }
};
