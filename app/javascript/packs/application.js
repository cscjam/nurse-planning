require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap";

// Internal imports
import { initJourneyChange } from '../components/init_journey_change.js'
import { initMinuteCreation } from '../components/init_minute_creation.js';
import { flatPickr } from "../plugins/flatpickr"

document.addEventListener('turbolinks:load', () => {
  initJourneyChange();
  initMinuteCreation();
  flatPickr();
});
