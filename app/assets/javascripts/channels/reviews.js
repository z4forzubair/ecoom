App.chat = App.cable.subscriptions.create("ReviewChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    // alert('received');
    // alert(data['reply']);
    // alert(reply);
    if(data['reply']=='n'){
      $('.append').prepend(data['review']);
    }
    else{
      // alert(data['comment_id']);
      $('.clearfix'+data['comment_id']).append(data['review']);
    }
    // }
  },
});
