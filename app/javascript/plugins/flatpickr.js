import flatpickr from "flatpickr"
import { French } from "flatpickr/dist/l10n/fr.js"


export const flatPickr = () => {
flatpickr(".datepicker", {
  "locale": French,
  altInput: true,
  altFormat: "j F Y",
  disableMobile: "true"
});
}
