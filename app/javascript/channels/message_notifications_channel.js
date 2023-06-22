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
    const receiverMessageDisplay = document.getElementById(`message-display-of-${data['receiver_id']}`);
    const chatLink = this.findRoomLink(data['receiver_id'], data['sender_id']);
    if(chatLink) {
      chatLink.insertAdjacentHTML('beforeend', this.templateWithMessagesCount(data));
    }
    if(chatsLink && receiverMessageDisplay === null) {
      chatsLink.insertAdjacentHTML('beforeend', this.template(data));
    } else if (chatsLink && receiverMessageDisplay) {
      const link = document.createElement('a');
      link.innerHTML = '<i class="bi bi-arrow-down"></i>';
      link.href = '#bottom';
      link.classList.add('scroll-to-bottom-link');

      const handleClick = (event) => {
        event.preventDefault();
        window.scrollTo({
          top: document.body.scrollHeight,
          behavior: 'smooth'
        });
        link.remove();
      };
      const isDisplayAreaAtBottom = (window.innerHeight + window.scrollY) >= document.body.offsetHeight;
      if (!isDisplayAreaAtBottom) {
        link.addEventListener('click', handleClick);
        document.body.appendChild(link);
      }
    }
  },
  template(data) {
    return `<span class="position-absolute top-0 start-100 translate-middle mt-2 p-1 bg-danger border border-light rounded-circle message-general-notification">
              <span class="visually-hidden">${data['sent_by']}s</span>
            </span>`
  },
  findRoomLink(firstSubscriberId, secondSubscriberId) {
    const firstTry = document.getElementById(`open-room-${firstSubscriberId}-${secondSubscriberId}`);
 
    if(firstTry === null) {
      const secondTry = document.getElementById(`open-room-${secondSubscriberId}-${firstSubscriberId}`);
      return secondTry;
    } else {
      return firstTry
    }
  },
  templateWithMessagesCount(data) {
    return `<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
              ${data['receiver_number_of_unread_messages']}
              <span class="visually-hidden">unread messages</span>
            </span>`
  }
});    
