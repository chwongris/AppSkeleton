class UsersController < ApplicationController
  before_filter :authenticate_user!, :get_user_account


  def index
    # binding.pry
    unread_messages = @account.api.request(:get, "accounts/#{@account.id}/sources/0/folders/INBOX/messages?flag_seen=0&limit=500")
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
    message = @account.messages["gm-"+params[:message_id]]
    message.move_to(params[:flag], @account.sources.first.label)
    
    render :json => {success: true}
  end

  def bulk_archive
    params[:message_ids].each do |message_id|
      message = @account.messages["gm-"+message_id]
      message.move_to(params[:flag], @account.sources.first.label)
    end

    render :json => {success: true}
  end

  def get_user_account
    user_email ||= current_user.email
    @contextio = ContextIO.new(ENV["CONTEXT_KEY"], ENV["CONTEXT_SECRET"])
    @account = @contextio.accounts.where(email: user_email).first    
  end



end
