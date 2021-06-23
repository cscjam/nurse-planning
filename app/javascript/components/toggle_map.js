
import { initMapboxes } from '../components/init_mapbox.js'

export const toggleMap = () => {
  const chevronMaps = document.querySelectorAll(".chevron-map");

  chevronMaps.forEach((content) => {
    const map = content.querySelector(".map");
    const icon = content.querySelector(".fa-chevron-down");
    icon.addEventListener("click", (event) => {
      event.preventDefault();
      map.classList.toggle("d-none");
      icon.classList.toggle("fa-chevron-down");
      icon.classList.toggle("fa-chevron-up");
      if(!map.classList.contains("d-none")){
        initMapboxes(icon.dataset.mapId);
      }
    });
  });
}
