import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput' ]

  connect() {
    flatpickr(this.startDateInputTarget, {
      "enableTime": true,
      mode: 'range',
      "plugins": [new rangePlugin({ input: this.endDateInputTarget})]
    })
  }
}
