Rails.application.config.middleware.use OmniAuth::Builder do
 provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"],
  {
      :scope => "https://mail.google.com/, https://www.googleapis.com/auth/plus.login, https://www.googleapis.com/auth/plus.me, https://www.googleapis.com/auth/userinfo.email, https://www.googleapis.com/auth/userinfo.profile",
      :prompt => "consent"
    }
end