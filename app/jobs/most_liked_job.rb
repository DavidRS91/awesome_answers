class MostLikedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AnswerMailer.notify_question_owner(Answer.last).deliver_now
  end
end
