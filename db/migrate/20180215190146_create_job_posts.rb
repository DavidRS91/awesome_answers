class CreateJobPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :job_posts do |t|
      t.string :title
      t.string :description
      t.string :company
      t.string :role
      t.string :location
      t.integer :salary_min
      t.integer :salary_max
      t.timestamps
    end
  end
end
