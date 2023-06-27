import consumer from "./consumer"

consumer.subscriptions.create("BookingNotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const servicesLink = document.getElementById(`services-link-of-${data['service_provider_id']}`);
    const bookingsLink = document.getElementById(`bookings-link-for-service-${data['service_id']}`);
    const consumerBookingsLink = document.getElementById(`consumer-${data['service_consumer_id']}-bookings-link`);
    const serviceDateButton = document.getElementById(`service-${data['service_id']}-on-${data['date']}`);
    const allLinks = [servicesLink, bookingsLink, serviceDateButton, consumerBookingsLink];
    allLinks.forEach((link) => {
      if(link) {
        link.insertAdjacentHTML('beforeend', this.template(data));
      }
    })
  },
  template(data) {
    return `<span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle">
              <span class="visually-hidden">New alerts</span>
            </span>`
  }
});
