class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_account

  def after_sign_in_path_for(resource_or_scope)
   return users_path
  end

  def get_account
    @contextio = ContextIO.new(ENV["CONTEXT_KEY"], ENV["CONTEXT_SECRET"])
  end

end
