import mapboxgl from 'mapbox-gl';

var g_padding = 30;
var g_maps = new Map();

const getPrettyInfos = (journey) => {
  let mins = journey.duration;
  let hours = Math.trunc(mins / 60)
  let duration = "";
  if ( hours > 0){
    duration += `${hours}h`;
  }
  duration += `${Math.trunc(mins % 60)}min`;
  let specificJourney = "";
  return "Trajet " + specificJourney + ": " + duration + " - " + journey.distance + "m";
}

const fitResizedScreen = (mapGui, mapElt, bounds) => {
    // _sw: SouthWest - _ne: NorthWest
    const widthSquare = mapElt.querySelector("canvas").width;
    const heightSquare = mapElt.querySelector("canvas").height;
    const widthRect = parseInt(mapElt.querySelector("canvas").style.width);
    const heightRect = parseInt(mapElt.querySelector("canvas").style.width);
    if(Math.abs(widthSquare - widthRect) < 10  || Math.abs(heightSquare != heightRect) < 10){
      const p0 = [0, 0];
      const p1 = [widthRect, heightRect];
      mapGui.fitScreenCoordinates(p0, p1, mapGui.getBearing(),{ padding: g_padding});
    }
}

const fitMapToMarkers = (mapGui, mapElt, markers, geometry) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  if (geometry.coordinates) {
    geometry.coordinates.forEach(point => bounds.extend(point));
  }
  mapGui.fitBounds(bounds, { padding: g_padding, maxZoom: 15, duration: 0 });
  return geometry;
};

const addMarkerFlag = (mapGui, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    const element = document.createElement('div');
    element.className = 'marker';
    element.style.width = '25px';
    element.style.height = '25px';
    new mapboxgl.Marker(element)
      .setLngLat([marker.lng, marker.lat])
      .setPopup(popup)
      .addTo(mapGui);
  });
}

const addMarkers = (mapGui, mapElt, geometry) => {
  const markers = JSON.parse(mapElt.dataset.markers);
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(mapGui);
  });
  addMarkerFlag(mapGui, markers);
  return [markers, geometry];
}

export const addGeometryJson = (mapGui, mapElt) => {

  fetch(`/journeys/${mapElt.dataset.journeyId}/geometry `)
    .then(response => response.json())
    .then((data) => {
      let geometry = data.geometry
      if(mapGui.getSource('trace')) {
        mapGui.removeLayer('trace')
        mapGui.removeSource('trace')
      }
      mapGui.addSource('trace', { type: 'geojson', data: null   });
      mapGui.addLayer({
        'id': 'trace',  'type': 'line', 'source': 'trace',
        'paint': {'line-color': '#FF9F74', 'line-opacity': 0.75, 'line-width': 5 } });
      return geometry;
    })
    .then((geometry) => {
      return addMarkers(mapGui, mapElt, geometry)
    })
    .then((data) => {
      return fitMapToMarkers(mapGui, mapElt, data[0], data[1])
    })
    .then((geometry) => {
      const coordinates = geometry.coordinates;
      geometry.coordinates = [];
      var i = 0;
      var timer = window.setInterval(function () {
        if (i < coordinates.length) {
          geometry.coordinates.push(coordinates[i]);
          mapGui.getSource('trace').setData(geometry);
          i++;
        } else {
          window.clearInterval(timer);
        }
      }, 150);
    })
};

export const  createMap = (mapElt) =>  {
  mapboxgl.accessToken = mapElt.dataset.mapboxApiKey;
  const mapGui = new mapboxgl.Map({
    container: mapElt.id,
    attributionControl: false,
    style: 'mapbox://styles/mapbox/streets-v10'
  })
  if(!g_maps.has(mapElt.id)) {
    g_maps.set(mapElt.id, mapGui);
  }
  mapGui.on('load', function () {
    addGeometryJson(mapGui, mapElt);
  })
};

export const  getMap = (mapElt) =>  {
    return g_maps.get(mapElt.id);
};

export const updateJourneysAbstractAndMaps = (data) => {
  if(data) {
    const journeysJson = data.journeys;
    const markers = data.markers;
    const journeysElts = document.querySelectorAll(".card-journey")
    const mapElts = document.querySelectorAll(".map")
    const togleElts = document.querySelectorAll(".fa-chevron")
    if(journeysJson && markers && mapElts && journeysElts) {
      for(let index = 0; index < journeysJson.length; index++){
        const journeyElt = journeysElts[index]
        journeyElt.id = `journey-${journeysJson[index]["id"]}`
        const journeyInfoElt = journeyElt.querySelector("p")
        if(journeyInfoElt) {
          let chevronIcon = "";
          const chevronIndex = journeyInfoElt.innerHTML.indexOf("<");
          if(chevronIndex != -1) {
            chevronIcon = journeyInfoElt.innerHTML.substr(chevronIndex);
          }
          chevronIcon = journeyInfoElt.innerHTML.substr(chevronIndex);
          journeyInfoElt.innerHTML = getPrettyInfos(journeysJson[index]) + chevronIcon;
        }
        const mapElt = mapElts[index]
        if(g_maps.has(mapElt.id )){
          g_maps.set(`map-${journeysJson[index]["id"]}`, g_maps.get(mapElt.id ))
        }
        mapElt.id = `map-${journeysJson[index]["id"]}`
        mapElt.dataset.markers = markers[index];
        mapElt.dataset.journeyId = journeysJson[index]["id"];
        const toggleElt = togleElts[index]
        if(toggleElt) {
          toggleElt.dataset.mapId = `map-${journeysJson[index]["id"]}`
        }
      }
    }
    return mapElts
  }
};

export const initMapboxes = (mapId) => {
  if(mapId){
    const mapElt = document.querySelector(`#${mapId}`);
    if (mapElt) {
      createMap(mapElt);
    }
  }else{
    const mapElts = document.querySelectorAll('.map ');
    mapElts.forEach(mapElt => {
      if (mapElt) {
        createMap(mapElt);
      }
    })
  }
};

