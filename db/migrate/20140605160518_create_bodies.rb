class CreateBodies < ActiveRecord::Migration
  def change
    create_table :bodies do |t|
      t.string :pol
      t.string :objective
      t.string :age
      t.string :fat
      t.string :bol
      t.string :kind_sport

      t.timestamps
    end
  end
end
