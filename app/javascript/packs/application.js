require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap";

// Internal imports
import { initMeteoInfo } from "../components/init_meteo"
import { initLocomotionChange } from '../components/init_locomotion_change.js'
import { initMinuteCreation } from '../components/init_minute_creation.js';
import { initSpeechApi } from "../components/init_speech_api.js";
import { initSortable } from "../plugins/init_sortable";
import { flatPickr } from "../plugins/flatpickr"
import { toggleDone } from "../components/toggle_done"
import { toggleMap } from "../components/toggle_map"
import { modal } from "../components/modal"
import { scrollVisitDown } from "../components/scroll_visit_down.js"

document.addEventListener('turbolinks:load', () => {
  initMeteoInfo();
  initLocomotionChange();
  initMinuteCreation();
  initSpeechApi();
  initSortable();
  flatPickr();
  toggleDone();
  toggleMap();
  modal();
  scrollVisitDown();
});
