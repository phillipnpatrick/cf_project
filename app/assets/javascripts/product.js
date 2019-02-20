$(document).on('turbolinks:load', function() {
  App.product = App.cable.subscriptions.create("ProductChannel", {
    connected: function() {
      // Called when the subscription is ready for use on the server
      App.product.listen_to_comments();
    },
    
    disconnected: function() {
      // Called when the subscription has been terminated by the server
    },
    
    received: function(data) {
      // Called when there's incoming data on the websocket for this channel
      var score = data.average_rating;
      // console.log("in product.js received function; data.average_rating = " + score);
      
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
      // console.log("hello from product.js listen_to_comments");
      // console.log("product_id = " + x);
      return this.perform('listen', {
        product_id: $("[data-product-id]").data("product-id")
      });
    }
  });
});