require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initMinuteCreation } from '../components/init_minute_creation.js';
import { flatPickr } from "../plugins/flatpickr"

document.addEventListener('turbolinks:load', () => {
  initMinuteCreation();
  flatPickr();
});
