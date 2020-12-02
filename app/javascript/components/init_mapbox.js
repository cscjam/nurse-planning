import mapboxgl from 'mapbox-gl';

const customFitMapToMarkers = (mapGui, mapElt, bounds) => {
    const rectHeight = 140;
    const squareHeight = mapElt.querySelector("canvas").height;
    // _sw: SouthWest - _ne: NorthWest
    const up = bounds["_ne"]['lng']
    const dw = bounds["_sw"]['lng']
    const r = (squareHeight / rectHeight);
    bounds["_sw"]['lng'] = up + ( dw - dw) * r;
}

const fitMapToMarkers = (mapGui, mapElt, markers, geometry) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  if (geometry) {
    geometry.forEach(point => bounds.extend(point));
  }
  // customFitMapToMarkers(mapGui, mapElt, bounds)
  mapGui.fitBounds(bounds, { padding: 20, maxZoom: 15, duration: 0 });
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

const addMarkers = (mapGui, mapElt) => {
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
      fitMapToMarkers(mapGui, mapElt, markers, data["geometry"]["coordinates"]);
    })
};

const createMap = (mapElt) =>  {
  mapboxgl.accessToken = mapElt.dataset.mapboxApiKey;
  const mapGui = new mapboxgl.Map({
    container: mapElt.id,
    attributionControl: false,
    style: 'mapbox://styles/mapbox/streets-v10'
  })
  mapGui.on('load', function () {
    const markers = addMarkers(mapGui, mapElt);
    addGeometryJson(mapGui, mapElt, markers);
  })
  return mapGui;
};

export const refreshMapboxes = () => {
  const mapElts = document.querySelectorAll('.map');
  mapElts.forEach(mapElt => {
    const mapGui = createMap(mapElt);
  })
};
// Mise à jour mapElt.dataset.markers = f(journey) => sort

export const initMapboxes = () => {
  const mapElts = document.querySelectorAll('.map ');
  mapElts.forEach(mapElt => {
    if (mapElt) {
      createMap(mapElt);
    }
  })
};

