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

  async updateSearch(event) {
    const checkboxes = document.querySelectorAll('input[type="checkbox"][name="service_categories[]"]'); 

    const checkedServiceCategories = Array.from(checkboxes)
                                          .filter(checkbox => checkbox.checked)
                                          .map(checkbox => checkbox.value);
    console.log('Checked values:', checkedServiceCategories);
    const params = new URLSearchParams();
    params.append('service_categories', checkedServiceCategories.join(','));
    const url = `/services/make_search?${params.toString()}`;
    const target = event.currentTarget;
    try {
      const response = await fetch(url, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
      });

      if (response.ok) {
        const previousButtons = document.querySelectorAll('.btn-triangle');
        previousButtons.forEach(function(element) {
          element.remove();
        });
        const data = await response.json();
        const newElement = document.createElement('button');
        newElement.classList.add('btn-triangle', 'btn', 'btn-sm', 'btn-secondary');
        console.log(data);
        newElement.textContent = `Show ${data.length} services`;
        const nextSibling = target.nextElementSibling;
        newElement.addEventListener('click', this.hideButton.bind(this));
        target.parentNode.appendChild(newElement, nextSibling);
      } else {
        console.error('Error:', response.status);
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };

  hideButton() {
    let button = document.getElementsByClassName('btn-triangle')[0];
    button.style.display = 'none';
  };
}
