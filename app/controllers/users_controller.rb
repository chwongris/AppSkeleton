class UsersController < ApplicationController
  before_filter :authenticate_user!


  def index
    # imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    # imap.authenticate('XOAUTH2', current_user.email , current_user.gtoken)
  gmail = Gmail.connect(:xoauth2, current_user.email, current_user.gtoken)
# binding.pry
    # imap.search(["UNSEEN"]).each do |message_id|
    #   envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
    #   emails << "#{envelope.from[0].name}: \t#{envelope.subject}"
    # end
    @unread_messages = gmail.inbox.emails(:unread).group_by { |m| m.message.from}
  
end

end
  