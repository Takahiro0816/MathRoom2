class RoomChannel < ApplicationCable::Channel
  def subscribed
     stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    message = Message.create!(content: data['message'])
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
    ActionCable.server.broadcast 'room_channel', template
    mondai = Message.create!(content: Reply.where( 'id >= ?', rand(Reply.first.id..Reply.last.id) ).first.content)
    template = ApplicationController.renderer.render(partial: 'messages/message', locals: {message: mondai})
    ActionCable.server.broadcast 'room_channel', template
  end
end
