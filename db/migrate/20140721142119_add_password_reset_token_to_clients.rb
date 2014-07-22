class AddPasswordResetTokenToClients < ActiveRecord::Migration
  def change
    add_column :clients, :password_reset_token, :string
    add_index  :clients, :password_reset_token
  end
end
