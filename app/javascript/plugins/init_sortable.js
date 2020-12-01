import Sortable from 'sortablejs';
import {fetchWithToken} from '../middleware/fetch_with_token';

const initSortable = () => {
  var list = document.querySelector('#card-list');
  var sortable = Sortable.create(list, {
    animation: 150,
    onEnd: (event) => {
      console.dir(event)
      console.dir(event.item)
      console.dir(event.item.dataset)
      const url = `/visits/${event.item.dataset.id}/move?old=${event.oldIndex}&new=${event.newIndex}`;
      fetchWithToken(url, {
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      method: 'PATCH',
      body: JSON.stringify( {} )
    })
  }
});
};

export { initSortable };
