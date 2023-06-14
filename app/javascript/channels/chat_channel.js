import consumer from "./consumer"

const currentRoom = document.getElementsByClassName('room')[0].id;

consumer.subscriptions.create({ channel: "ChatChannel", room: currentRoom }, {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messageField = document.getElementById('message-input');
    messageField.value = '';
    const messageDisplay = document.querySelector('#message-display');
    messageDisplay.insertAdjacentHTML('beforeend', this.template(data));

  },
  template(data) {
    return `<div class="message">
              <div class="message-header">
                <p>${data['sent_by']}</p>
              </div>
              <div class="message-body">
                <p>${data['body']}</p>
              </div>
            </div>`
  }
});    
