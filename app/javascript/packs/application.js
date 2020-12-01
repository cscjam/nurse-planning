require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap";

// Internal imports
import { initJourneyChange } from '../components/init_journey_change.js'
import { initMinuteCreation } from '../components/init_minute_creation.js';
import { initSpeechApi } from "../components/init_speech_api.js";
import { flatPickr } from "../plugins/flatpickr"
import { toggleDone } from "../components/toggle_done"

document.addEventListener('turbolinks:load', () => {
  initJourneyChange();
  initSpeechApi();
  initMinuteCreation();
  flatPickr();
  toggleDone();
});

// Get the modal
const modal = document.getElementById("myModal");

// Get the image and insert it inside the modal - use its "alt" text as a caption
const img = document.querySelectorAll("myImg");
const modalImg = document.getElementById("img01");
img.addEventListener("click", (event) => {

}
// img.onclick = function(){
//   modal.style.display = "block";
//   modalImg.src = this.src;
// }

// Get the <span> element that closes the modal
const span = document.getElementsByClassName("close")[0];

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
  modal.style.display = "none";
}
