import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "box" ]

  connect() {
    console.log(this.boxTargets);
  }

  toggle(event) {
    this.boxTargets.forEach((box) => {
      box.checked = event.currentTarget.checked;
    })
  }
}
