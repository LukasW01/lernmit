class CreateLearnsets < ActiveRecord::Migration[7.1]
  def change
    create_table :learnsets do |t|
      t.string :title
      t.string :desc
      t.integer :user_id

      t.timestamps
    end
  end
end
