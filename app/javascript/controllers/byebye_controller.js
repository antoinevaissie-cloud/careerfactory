import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="byebye"
export default class extends Controller {
  connect() {
    console.log("bye bye");
  }
}
