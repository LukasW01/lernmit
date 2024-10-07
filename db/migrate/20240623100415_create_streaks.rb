class CreateStreaks < ActiveRecord::Migration[7.1]
  def change
    create_table :streaks do |t|
      t.integer :user_id
      t.datetime :created_at
      t.string :types
    end
  end
end
