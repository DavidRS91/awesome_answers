class Api::V1::QuestionsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: [:show, :update, :destroy]
  # /api/v1/questions
  # /api/v2/questions
  def index
    questions = Question.order(created_at: :desc)
    render json: questions
  end

  def show
    render json: @question
  end

  def create
    question = Question.new question_params
    question.user = current_user
    question.save!
    render json: {id: question.id}
  end

  private
  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
