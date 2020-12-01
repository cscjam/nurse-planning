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
import { modal } from "../components/modal"

document.addEventListener('turbolinks:load', () => {
  initJourneyChange();
  initSpeechApi();
  initMinuteCreation();
  flatPickr();
  toggleDone();
  modal();
});


