class QuestionsController < ApplicationController
  before_action :find_question, except: [:index, :create, :new]
  def index
    # Instance (@name) variables defined in controllers are equally accessible inside templates
    # Use them to pass data to your views
    @questions = Question.order(created_at: :desc)
  end

  def new
    # render plain: "This link is working!"
    @question = Question.new
  end

  def create
    @question = Question.new question_params

    if @question.save
      redirect_to question_path(@question)
    else
      render :new
      # @question.errors.full_message
    end
  end

  def edit

  end

  def update

    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy

    @question.destroy
    redirect_to questions_path
  end

  def show

    @answers = @question.answers
    @answer = Answer.new
    # render json: @question
  end

  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    #require will extract a nested hash from the params by its keys name
    params.require(:question).permit(:title, :body)

  end


end
