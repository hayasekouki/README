class AddLikeCountToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :like_count, :integer, default: 0
  end
end
