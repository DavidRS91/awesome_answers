class SurveyQuestionsController < ApplicationController
  before_action :authenticate_user!

  def new
      @survey_question = SurveyQuestion.new
  end

  def create
    survey_question_params = params.require(:survey_question).permit(:body)
    @survey_question = SurveyQuestion.new survey_question_params
    if @survey_question.save
      redirect_to root_path
    end
  end
end
