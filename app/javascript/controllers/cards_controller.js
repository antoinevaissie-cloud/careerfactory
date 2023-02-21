// controllers/cards_controller.js
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "General-index-card" ]

  selectCard(event) {
    let checkbox = event.currentTarget.querySelector(".hidden-checkbox")
    checkbox.checked = !checkbox.checked
    this.handleCheckboxChange(checkbox)
  }

  handleCheckboxChange(checkbox) {
    if (checkbox.checked) {
      // do something when the checkbox is checked
    } else {
      // do something when the checkbox is unchecked
    }
  }
}
