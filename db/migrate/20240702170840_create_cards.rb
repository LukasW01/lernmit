class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.integer :learnsets_id
      t.string :term
      t.string :defintion

      t.timestamps
    end
  end
end
