import Sortable from 'sortablejs';
import {fetchWithToken} from '../middleware/fetch_with_token';
import {updateMapElts} from '../components/init_mapbox';

const sortMapinfos = () => {
  // Fixer
  let url = `/visits`
  fetch(url, { headers: { accept: "application/json" } })
  .then(response => response.json())
  .then((data) => {
    updateMapElts(data);
  });
};

export const initSortable = () => {
  var list = document.querySelector('#card-list');
  Sortable.create(list, {
    animation: 150,
    onEnd: (event) => {
      const url = `/visits/${event.item.dataset.id}/move?old=${event.oldIndex}&new=${event.newIndex}`;
      fetchWithToken(url, {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        method: 'PATCH',
        body: JSON.stringify( {} )
      })
      .then(() => sortMapinfos())
    }
  });
};
