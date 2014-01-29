class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

def login_gmail
  Gmail.new('christest27@gmail.com', 'wordpass`')
end

def get_unread
  login_gmail.inbox.emails(:unread)
end

def sort_by_sender
 
end

end
