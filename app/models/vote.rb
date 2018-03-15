class Vote < ApplicationRecord

  belongs_to :user
  belongs_to :answer

  validates :answer_id, uniqueness: {
    scope: :user_id,
    message: 'has already been voted on'
  }

  # validates presence: true does not work with bolleans, use the below instead
  validates :is_up, inclusion: {
    in: [true, false]
  }

  def self.up
    where(is_up: true)
  end

  def self.down
    where(is_up: false)
  end


end
