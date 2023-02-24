import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

Connects to data-controller="typed"
export default class extends Controller {
  connect() {
    var options = {
      strings: ['Configure', 'Your campaign', 'below'],
      typeSpeed: 40
    };

    var typed = new Typed('.typing-element', options);
  }
}
