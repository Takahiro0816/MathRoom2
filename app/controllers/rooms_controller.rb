class RoomsController < ApplicationController
  def show
    @messages = Message.all
  #  @replies = Reply.all 
  end
end
