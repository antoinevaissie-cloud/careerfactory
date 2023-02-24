import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-bookings"
export default class extends Controller {
  static targets = ["results"]

  connect() {

    console.log('hello')

    fetch(`https://api.cal.com/v1/bookings?apiKey=cal_live_4afa37f5e71a4c0012cadf97b34414a7`)
      .then(response => response.json())


      .then((data) => {
        results.innerHTML = "";
        data.bookings.forEach((booking) => {
          console.log('booking', booking)
          const bookingTitle = `<li>Booking status: ${booking.title}</li>`;
          const bookingStatus = `<li>Booking status: ${booking.status}</li>`;
          results.insertAdjacentHTML("afterbegin", bookingTitle, bookingStatus);
        });
      });
  }

}
