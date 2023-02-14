import { Controller } from "@hotwired/stimulus"
import Typed from 'typed.js';

// Connects to data-controller="typed"
export default class extends Controller {
  connect() {
    var options = {
      strings: ['The best experience', 'For recruiters', 'For candidates', 'For career managers'],
      typeSpeed: 40
    };

    var typed = new Typed('.typing-element', options);
  }
}
