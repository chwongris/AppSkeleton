class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    @account = @contextio.accounts.where(email: current_user.email).first
    unread_messages = @account.api.request(:get, "accounts/#{@account.id}/sources/0/folders/INBOX/messages?flag_seen=0&limit=100")
    unread_messages = unread_messages.group_by { |m| m["addresses"]["from"]["name"]}
    unread_messages = unread_messages.sort_by do |m| 
      m[1].count
    end    
    @grouped_unread_messages = unread_messages.reverse

    respond_to do |format|
      format.html
      format.json { render :json => { :emails => @grouped_unread_messages, :token => form_authenticity_token } }
    end
  end

  def archive
    account = @contextio.accounts.where(email: current_user.email).first
    message = account.messages["gm-"+params[:message_id]]
    message.move_to(params[:flag], account.sources.first.label)
    render :json => "success"
  end


end
