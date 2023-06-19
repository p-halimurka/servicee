import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chats"
export default class extends Controller {
  connect() {
  }

  scrollToBottom() {
    setTimeout(() => {
      window.scrollTo(0, document.body.scrollHeight);
    }, 1700);
    setTimeout(() => {
      const unreadMessages = document.querySelectorAll('.message-to-be-updated');
      const unreadMessagesIds = this.extractMessagesIds(unreadMessages);
      this.updateMessagesRead(unreadMessagesIds, true);
    }, 3000);
  }

  async updateMessagesRead(messagesIds, read) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const url = `/messages/update_collection`;
    const params = JSON.stringify({ ids: messagesIds, read: read });
    console.log(params);
    try {
      const response = await fetch(url, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: params
      });
  
      const result = await response.json();
      return result;
    } catch (error) {
      console.error('Error:', error);
      throw error;
    }
  }

  extractMessagesIds(messageElements) {
    const messageElementsArray = messageElements;
    const ids = [];
    messageElementsArray.forEach((element) => {
      const classes = element.classList;
    
      classes.forEach((className) => {
        // Check if the class matches the pattern "message-{integer}"
        if (className.match(/^message-\d+$/)) {
          const integer = parseInt(className.split('-')[1]);
          ids.push(integer); // Collect the extracted integer into the array
        }
      });
    });
    return ids;
  }
}
