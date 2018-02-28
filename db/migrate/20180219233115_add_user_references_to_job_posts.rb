class AddUserReferencesToJobPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :job_posts, :user, foreign_key: true
  end
end
