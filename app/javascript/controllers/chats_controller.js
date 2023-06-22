import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chats"
export default class extends Controller {
  connect() {
    const currentPath = window.location.pathname;
    const roomPathPattern = /^\/rooms\/\d+$/;
    if (roomPathPattern.test(currentPath)) {
      this.scrollToBottom();
    }
  }

  scrollToBottom() {
    const messageGeneralNotification = document.getElementsByClassName('message-general-notification');
    window.scrollTo(0, document.body.scrollHeight);
    if(messageGeneralNotification.length > 0) {
      messageGeneralNotification[0].remove();
    };
    const unreadMessages = document.querySelectorAll('.message-to-be-updated');
    const unreadMessagesIds = this.extractMessagesIds(unreadMessages);
    this.updateMessagesRead(unreadMessagesIds, true);
  }

  async updateMessagesRead(messagesIds, read) {
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
    const url = `/messages/update_collection`;
    const params = JSON.stringify({ ids: messagesIds, read: read });
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
