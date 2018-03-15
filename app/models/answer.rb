class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :body, presence: true
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  def vote_total
    votes.up.count - votes.down.count
  end

end
