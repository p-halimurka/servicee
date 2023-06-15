import consumer from "./consumer"

consumer.subscriptions.create("MessageNotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const chatsLink = document.getElementById(`chats-link-of-${data['receiver_id']}`);
    if(chatsLink) {
      chatsLink.insertAdjacentHTML('beforeend', this.template(data));
    }
  },
  template(data) {
    return `<span class="position-absolute top-0 start-100 translate-middle mt-2 p-1 bg-danger border border-light rounded-circle">
              <span class="visually-hidden">${data['sent_by']}s</span>
            </span>`
  }
});    
