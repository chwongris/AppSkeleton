class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @account = @contextio.accounts.where(email: current_user.email).first
    unread_messages = @account.api.request(:get, "accounts/#{@account.id}/sources/0/folders/INBOX/messages?flag_seen=0")
    @grouped_unread_messages = unread_messages.group_by { |m| m["addresses"]["from"]["name"]}
  end

end
