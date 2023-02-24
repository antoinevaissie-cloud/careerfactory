import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="goodbye"
export default class extends Controller {
  // static targets = ['content']

  connect() {
    console.log("Connected:", this.element);
  }
  sayGoodbye() {
    this.contentTarget.innerHTML = "GOODBYE !"
  }
}
