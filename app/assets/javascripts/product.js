App.product = App.cable.subscriptions.create("ProductChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("in product.js received function");
    
    $(".alert.alert-info").show();
    
    $("#product_reviews").prepend(data.comment);

    refreshRating();

    $('#average-rating').raty('readOnly', false);
    $('#average-rating').raty('score', "<%= @product.average_rating %>");
    $('#average-rating').raty('readOnly', true);
  },
  
  listen_to_comments: function() {
    var x = $("[data-product-id]").data("product-id");
    console.log("hello from product.js listen_to_comments");
    console.log("product_id = " + x);
    return this.perform('listen', {
      product_id: $("[data-product-id]").data("product-id")
    });
  }
});

$(document).on('turbolinks:load', function() {
  App.product.listen_to_comments();
});