import mapboxgl from 'mapbox-gl';

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
  if(journeysJson) {
    for(let index = 0; index < journeysJson.length; index++){
      const journeyElt = document.querySelector(`#journey-${index} .card-journey-info p`);
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
      let url = `/visits?locomotion=${locomotionElt.value}`
      fetch(url, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        updateJourneysCards(data["journeys"])
      });
    });
  }
};

const fitMapToMarkers = (mapGui, markers, geometry) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  geometry.forEach(point => bounds.extend(point));
  mapGui.fitBounds(bounds, { padding: 20, maxZoom: 15, duration: 0 });
};

const addMarkerFlag = (mapGui, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    // Create a HTML element for your custom marker
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.width = '25px';
    element.style.height = '25px';
    // Pass the element as an argument to the new marker
    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(mapGui);
  });
}

const addAndFitMarkers = (mapGui, mapElt) => {
  const markers = JSON.parse(mapElt.dataset.markers);
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(mapGui);
  });
  addMarkerFlag(mapGui, markers);
  return markers;
}

const addGeometryJson = (mapGui, mapElt, markers) => {
  fetch(`/journeys/${mapElt.dataset.journeyId}/geometry `)
    // .then(response => {
    .then(response => response.json())
    .then((data) => {
      mapGui.addSource('lines', {
        'type': 'geojson',
        'data': {
          'type': 'FeatureCollection',
          'features': [
          {
            'type': 'Feature',
            'properties': {
              'color': '#FF9F74'
            },
            'geometry': data["geometry"]
          }]
        }
      });
      mapGui.addLayer({
        'id': 'lines', 'type': 'line', 'source': 'lines', 'paint': { 'line-width': 3,
        'line-color': ['get', 'color']
        }
      });
      fitMapToMarkers(mapGui, markers, data["geometry"]["coordinates"]);
    })
};

export const initMapboxes = () => {
  const mapElts = document.querySelectorAll('.map ');
  mapElts.forEach(mapElt => {
    if (mapElt) { // only build a map if there's a div#map to inject into
      mapboxgl.accessToken = mapElt.dataset.mapboxApiKey;
      const mapGui = new mapboxgl.Map({
        container: mapElt.id,
        attributionControl: false,
        style: 'mapbox://styles/mapbox/streets-v10'
      })
      mapGui.on('load', function () {
        const markers = addAndFitMarkers(mapGui, mapElt);
        const geometry = addGeometryJson(mapGui, mapElt, markers);
      })
    };
  })
};

