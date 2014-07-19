module SessionsHelper

  def sign_in(client)
    remember_token = Client.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    client.update_attribute(:remember_token, Client.encrypt(remember_token))
    self.current_client = client
  end

  def current_client=(client)
    @current_client = client
  end
  def current_client
    remember_token = Client.encrypt(cookies[:remember_token])
    @current_client ||= Client.find_by(remember_token: remember_token)
  end
end
