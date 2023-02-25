import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-bookings"
export default class extends Controller {
  static targets = ["results"]
  static values = {
    apiKey: String,
  }

  connect() {

    // fetch(`https://api.cal.com/v1/bookings?apiKey=${this.apiKeyValue}`)
    //   .then(response => response.json())

    //   .then((data) => {
    //     results.innerHTML = "";
    //     data.bookings.forEach((booking) => {

    //       const bookingTitle = `<li>Booking status: ${booking.title}</li>`;
    //       const bookingStatus = `<li>Booking status: ${booking.status}</li>`;

    //       results.insertAdjacentHTML("afterbegin", bookingTitle, bookingStatus);
    //     });
    //   });
  }

}
