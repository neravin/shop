class SessionsController < ApplicationController
  skip_before_action :authorize
  def new  
  end

  def create
    client = Client.find_by(email: params[:session_user][:email].downcase)
    if client && client.authenticate(params[:session_user][:password])
      # Sign the client in and redirect to the client's show page.
      sign_in client
      redirect_to client
    else
      # Create an error message and re-render the signin form.
      flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end  
  end

  def destroy
    
  end
end
