import consumer from "./consumer"

const currentRoom = document.getElementsByClassName('room')[0];
if(currentRoom) {
  const currentRoomId = currentRoom.id;

  consumer.subscriptions.create({ channel: "ChatChannel", room: currentRoomId }, {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      const messageField = document.getElementById('message-input');
      if(messageField) {
        messageField.value = '';
      };
      const receiverMessageDisplay = document.getElementById(`message-display-of-${data['receiver_id']}`);
      const senderMessageDisplay = document.getElementById(`message-display-of-${data['sender_id']}`);
      if(receiverMessageDisplay) {
        receiverMessageDisplay.insertAdjacentHTML('beforeend', this.receiverTemplate(data));
        const messageRead = this.isElementInViewport(receiverMessageDisplay);
        console.log(messageRead);
        this.updateMessageRead(data['message_id'], messageRead)
      };
      if(senderMessageDisplay) {
        senderMessageDisplay.insertAdjacentHTML('beforeend', this.senderTemplate(data));
        const messageRead = this.isElementInViewport(senderMessageDisplay);
      };

    },
    receiverTemplate(data) {
      return `<div class="message">
                <div class="message-header d-flex justify-content-start">
                  <p>${data['sent_by']}</p>
                </div>
                <div class="message-body d-flex justify-content-start">
                  <div class='card p-1 message-card receiver-message'>
                    ${data['body']}
                  </div>
                </div>
              </div>`
    },
    senderTemplate(data) {
      return `<div class="message">
                <div class="message-header d-flex justify-content-end">
                  <p>${data['sent_by']}</p>
                </div>
                <div class="message-body d-flex justify-content-end">
                  <div class='card p-1 message-card sender-message'>
                    ${data['body']}
                  </div>
                </div>
              </div>`
    },
    isElementInViewport(divElement) {
    
      // Get the position of the div relative to the viewport
      const rect = divElement.getBoundingClientRect();
    
      // Check if the div is in the active area of the screen
      const isInViewport = (
        rect.top >= 0 &&
        rect.left >= 0 &&
        rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
        rect.right <= (window.innerWidth || document.documentElement.clientWidth)
      );
    
      return isInViewport;
    },

    async updateMessageRead(messageId, read) {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').content;
      const url = `/messages/${messageId}`;
      const params = { id: messageId, read: read };
      try {
        const response = await fetch(url, {
          method: 'PUT',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          },
          body: JSON.stringify(params)
        });
    
        const result = await response.json();
        return result;
      } catch (error) {
        console.error('Error:', error);
        throw error;
      }
    }
  });    
}

