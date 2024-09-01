class Like < ApplicationRecord
  validates :question_id, presence: true, uniqueness: true
  validates :like_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end