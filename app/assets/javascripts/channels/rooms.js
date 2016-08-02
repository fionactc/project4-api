$(document).ready(function() {
  var messages;
  messages = $('#messages');
  if ($('#messages').length > 0) {
    messages_to_bottom = function() {
      return messages.scrollTop(messages.prop("scrollHeight"));
    };

    messages_to_bottom();

    // subscribe to channel
    App.global_chat = App.cable.subscriptions.create(
      {
        channel: "ChatRoomsChannel",
        chat_room_id: messages.data('chat-room-id')
      },
      {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {
          messages.append(data['message']);
          messages_to_bottom();
        },
        send_message: function(message, chat_room_id) {
          this.perform('send_message', {
            message: message,
            chat_room_id: chat_room_id
          });
        }
      }
    );

    // listen for submit event
    $('#new_message').submit(function(e) {
      var $this, textarea;
      $this = $(this);
      textarea = $this.find('#message_body');
      if ($.trim(textarea.val()).length > 1) {
        // call send_message to broadcast new message to all people in this chatroom
        App.global_chat.send_message(textarea.val(), messages.data('chat-room-id'));
        textarea.val('');
      }
      e.preventDefault();
      return false;
    });
  }

});
