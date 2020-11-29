const getPrettyInfos = (journey) => {
  let mins = journey["duration"];
  let hours = Math.trunc(mins / 60)
  let duration = "";
  if ( hours > 0){
    duration += `${hours}h`;
  }
  duration += `${Math.trunc(mins % 60)}min`;
  let specificJourney = "";
  if(null != journey["start_user_id"]){
    specificJourney = "depuis domicile "
  }
  if(null != journey["end_user_id"]){
    specificJourney = "vers domicile "
  }
  return "Trajet " + specificJourney + ": " + duration + " - " + journey["distance"] + "m";
}

const updateJourneysCards = (journeysJson) => {
  console.log(journeysJson)
  if(journeysJson) {
    for(let index = 0; index < journeysJson.length; index++){
      const journeyElt = document.querySelector(`#journey-${index} .card-journey-info p`);
      console.log(journeyElt);
      if(journeyElt) {
        journeyElt.innerText = getPrettyInfos(journeysJson[index])
      }
    };
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
        console.log(data);
        updateJourneysCards(data["journeys"])
      });
    });
  }
};
