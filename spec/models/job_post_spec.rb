require 'rails_helper'

RSpec.describe JobPost, type: :model do

  def job_post
    # @job_post ||= JobPost.new(
    #   title: 'Creativity Engineer',
    #   salary_min: 50_000
    # )
    @job_post ||= FactoryBot.build :job_post
  end
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'validations' do
    it 'requires a title' do
      # given: new JobPost record
      j = job_post
      j.title = ''

      #when condition
      j.valid?

      # Then: we get an error on the title field
      expect(j.errors.messages).to have_key(:title)
    end
    it 'requires a unique title' do
        # GIVEN: Created a job post with a title and a second one with the same title
        job_post.save
        jp = JobPost.new(title: job_post.title)

        # WHEN: Invoke validations
        jp.valid?

        # THEN: We get an error message on the title
        expect(jp.errors.messages).to have_key(:title)
      end
    it 'requires a description' do

     end
    it 'requires a numerical salary_min'do
    # Given
      j = job_post
      j.salary_min = 'string, not numerical'
      #then
      j.valid?
    # when
      expect(j.errors.messages).to have_key(:salary_min)
    end
    it 'requires a salary_min greater that 30 000'do
    j = job_post
    j.salary_min = 29_999
    #then
    j.valid?
    # when
    expect(j.errors.messages).to have_key(:salary_min)

    end
  end
  describe '#titleized_title' do
    it 'titleizes the title' do
    jp = job_post
    jp.title = 'Extreme Sea arbitrator'

    # When
    titleized_title = jp.titleized_title

    # Then
    expect(titleized_title).to eq("Extreme Sea Arbitrator")
    end
  end
end
