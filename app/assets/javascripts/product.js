$(document).on('turbolinks:load', function() {
  App.product = App.cable.subscriptions.create("ProductChannel", {
    connected: function() {
      // Called when the subscription is ready for use on the server
      console.log("ProductChannel connected");
      App.product.listen_to_comments();
    },
    
    disconnected: function() {
      // Called when the subscription has been terminated by the server
      console.log("ProductChannel disconnected");
    },
    
    received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      var score = data.average_rating;
      console.log("ProductChannel received; data.average_rating = " + score);
      
      $(".alert.alert-info").show();
      
      $("#product_reviews").prepend(data.comment);

      initRating();
      initRated();
      
      $('#average-rating').raty('readOnly', false);
      $("#average-rating").raty('score', score);
      $('#average-rating').raty('readOnly', true);
    },
    
    listen_to_comments: function() {
      var x = $("[data-product-id]").data("product-id");
      console.log("ProductChannel listen_to_comments; product_id = " + x);
      return this.perform('listen', {
        product_id: $("[data-product-id]").data("product-id")
      });
    }
  });
});