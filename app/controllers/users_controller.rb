class UsersController < ApplicationController
before_filter :authenticate_user!

def index
  messages = current_user.get_unread
  @unread_messages = messages.group_by { |m| m.message.from}
end

end
