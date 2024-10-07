class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :text
      t.string :status, default: 'upcoming'
      t.string :types
      t.datetime :due_date
      t.integer :points
      t.integer :user_id
      t.timestamps
    end

    add_index :tasks, :user_id
  end
end
