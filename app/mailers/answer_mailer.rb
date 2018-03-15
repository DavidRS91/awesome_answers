class AnswerMailer < ApplicationMailer
  def notify_question_owner(answer)
    @answer = answer
    @question = answer.question
    @question_owner = @question.user

    mail(
      to: @question_owner.email,
      subject: 'You got a new answer! 🤙🏼'
    )
  end
end
