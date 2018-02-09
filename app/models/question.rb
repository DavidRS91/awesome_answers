class Question < ApplicationRecord


  # Database Relationships
  has_many :answers, dependent: :destroy

  # Validations
  validates :title, presence: true, uniqueness: true
  validates :body, presence: {message: "must be given"}, length: {minimum: 5, maximum: 2000}
  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  before_validation(:set_view_count)


  private

  def set_view_count
    self.view_count ||= 0
  end


end
