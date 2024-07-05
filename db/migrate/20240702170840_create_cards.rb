class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.integer :learnset_id
      t.string :term
      t.string :definition

      t.timestamps
    end
  end
end
