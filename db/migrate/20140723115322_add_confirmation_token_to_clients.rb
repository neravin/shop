class AddConfirmationTokenToClients < ActiveRecord::Migration
  def change
    add_column :clients, :confirmation_token, :string
  end
end
