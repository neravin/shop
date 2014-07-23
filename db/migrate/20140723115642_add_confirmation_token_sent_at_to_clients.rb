class AddConfirmationTokenSentAtToClients < ActiveRecord::Migration
  def change
    add_column :clients, :confirmation_token_sent_at, :datetime
  end
end
