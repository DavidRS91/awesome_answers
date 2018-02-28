class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy

  # Because the name of our `has_many` association corresponds
  # to our source model (i.e. question), we do not need
  # to provide a source argument. Rails will infer it
  # automatically
  has_many :questions, through: :taggings#, source: :question

  validates :name, presence: true, uniqueness: {
    case_sensitive: false
    # the case_sensitive option will make uniqueness
    # validation ignore case. For example, two records
    # with names "ARTS" and "Arts" can't co-exist.
  }
  before_validation :downcase_name

  private
  def downcase_name
    self.name.downcase!
  end
end
