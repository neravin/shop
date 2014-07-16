class CreateVids < ActiveRecord::Migration
  def change
    create_table :vids do |t|
      t.string :eat_t

      t.timestamps
    end
  end
end
