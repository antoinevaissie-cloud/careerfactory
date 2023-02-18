// controllers/cards_controller.js

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "general-index-container" ]

  selectCard(event) {
    event.currentTarget.classList.toggle("selected")
  }
}
