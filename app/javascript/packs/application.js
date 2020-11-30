require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// External imports
import "bootstrap";

// Sortable

import Sortable from 'sortablejs';

// Internal imports
import { initJourneyChange } from '../components/init_journey_change.js';
import { initMinuteCreation } from '../components/init_minute_creation.js';
import { initSpeechApi } from "../components/init_speech_api.js";
<<<<<<< HEAD
import { flatPickr } from "../plugins/flatpickr";
import { initSortable} from '../plugins/init_sortable.js';
import { toggleDone } from "../components/toggle_done";


document.addEventListener('turbolinks:load', () => {
  initJourneyChange();
  initSpeechApi();
  initMinuteCreation();
  flatPickr();
  initSortable();
  toggleDone();
});





