# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel

  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatrooms:#{chatroom.id}"
    end
  end

  def speak(data)
    MessageRelayJob.perform_later data
  end

  def add(data)
    stream_from "chatrooms:#{data['chatroom_id']}"
  end

  def unsubscribed
    stop_all_streams
  end
end
