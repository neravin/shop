class ChangeClientsState < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :clients do |t|
        dir.up  { t.change :state, :integer }
        dir.down    { t.change :state, :decimal }
      end
    end
  end
end
