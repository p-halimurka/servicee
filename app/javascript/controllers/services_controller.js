import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="services"
export default class extends Controller {
  connect() {
  }

  switchPriciingType(event) {
    let pricingType = event.target.value;
    let durationInput = document.getElementById('duration_in_minutes');
    switch(pricingType) {
      case '0':
        durationInput.removeAttribute('disabled');
        break
      case '1':
        durationInput.disabled = true;
        break
    }
  }
}
