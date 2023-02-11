// app/javascript/controllers/multi_select_controller.js

import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    console.log(this.variableName);
  }
}
