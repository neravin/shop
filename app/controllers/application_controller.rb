class ApplicationController < ActionController::Base
  before_action :authorize

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  def session_admin?
    !session[:user_id].nil? 
  end

  protected
    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
      end
    end
     def is_admin
       if User.find_by(id: session[:user_id])
          @orders = Order.all
       elsif signed_in?
          @orders = Order.where(client_id: current_client.id)
       else redirect_to home_url, notice: "Пожалуйста, пройдите авторизацию"
      end
   end

end
