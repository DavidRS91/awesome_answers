class RemoveLikeCountFromQuestion < ActiveRecord::Migration[5.1]
  def change
    remove_column :questions, :like_count, :integer
  end
end
