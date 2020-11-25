require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// External imports
import "bootstrap";

// Internal imports, e.g:
import { initSpeechApi } from '../components/init_speech_api.js';

document.addEventListener('turbolinks:load', () => {
  initSpeechApi();
});
