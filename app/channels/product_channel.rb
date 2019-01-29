class ProductChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "product_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def listen(data)
    logger.debug "DEBUG: Inside product_channel.listen(data)"
    logger.debug "DEBUG: data['product_id'] is #{data['product_id']}"
    
    stop_all_streams
    
    stream_for data["product_id"]
  end
end
