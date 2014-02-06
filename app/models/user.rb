class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

def login_gmail
  gmail = Gmail.new('christest27@gmail.com', 'wordpass`', peek: true)
  gmail.peek = true
  return gmail
end

def get_unread
  login_gmail.inbox.emails(:unread)
end

def sort_by_sender
 
end

def self.from_omniauth(auth)
  where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
end

def self.create_from_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["nickname"]
  end
end

end


# class GmailManager
#   APP_ID      = "550834385030.apps.googleusercontent.com"
#   APP_SECRET  = "AIzaSyBPsn3hIcveMD8AIFSYgc0ydzMbTnbPC10"

#   def refresh_token(refresh_token)
#     Rails.logger.info "[GmailManager:refresh_token] refreshing using this refresh_token: #{refresh_token}"
#     # Refresh auth token from google_oauth2 and then requeue the job.
#     options = {
#       body: {
#         client_id:     APP_ID,
#         client_secret: APP_SECRET,
#         refresh_token: refresh_token,
#         grant_type:    'refresh_token'
#       },
#       headers: {
#         'Content-Type' => 'application/x-www-form-urlencoded'
#       }
#     }
#     response = HTTParty.post('https://accounts.google.com/o/oauth2/token', options)
#     if response.code == 200
#       token = response.parsed_response['access_token']
#       expires_in = DateTime.now + response.parsed_response['expires_in'].seconds
#       Rails.logger.info "Success! token: #{token}, expires_in #{expires_in}"
#       return token, expires_in
#     else
#       Rails.logger.error "Unable to refresh google_oauth2 authentication token."
#       Rails.logger.error "Refresh token response body: #{response.body}"
#     end
#     return nil, nil
#   end

#   def refresh_token_if_needed(token, expires_on, refresh_token)
#     if token.nil? or expires_on.nil? or Time.now >= expires_on
#       Rails.logger.info "[GmailManager:refresh_token_if_needed] refreshing using this refresh_token: #{refresh_token}"
#       new_token, new_expires_on = self.refresh_token(refresh_token)
#       if !new_token.nil? and !new_expires_on.nil?
#         return new_token, new_expires_on
#       end
#     else
#       Rails.logger.info "[GmailManager:refresh_token_if_needed] not refreshing. using this token: #{token}"
#     end
#     return token, expires_on
#   end
# end

