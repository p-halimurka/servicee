import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="registrations"
export default class extends Controller {
  connect() {
  }

  switchUserType(e) {
    e.preventDefault();
    const { url } = e.target.dataset;
    this.element.src = url;
  }
}
