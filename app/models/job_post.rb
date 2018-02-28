class JobPost < ApplicationRecord
  belongs_to :user
  validates :title, uniqueness: true, presence: true
  validates :salary_min, numericality: {greater_than_or_equal_to: 30_000}

  def titleized_title
    title.titleize
  end
end
