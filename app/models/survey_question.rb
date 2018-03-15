class SurveyQuestion < ApplicationRecord
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options
  validates :body, presence: true

end
