class CreateOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :options do |t|
      t.string :body
      t.references :survey_question, foreign_key: true

      t.timestamps
    end
  end
end
