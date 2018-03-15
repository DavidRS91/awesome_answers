class QuestionsController < ApplicationController
  before_action :find_question, except: [:index, :create, :new]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
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
    @question.user = current_user

    if @question.save
      redirect_to question_path(@question)
    else
      render :new
      # @question.errors.full_message
    end
  end

  def show
    @answer = Answer.new
    @answers = @question.answers.order(created_at: :desc)
    # this will find a `like` object with user_id of currently logged in user
    # and `question_id` of current questions we're showing. @like will be `nil`
    # if the user has not liked this question before
    @like = @question.likes.find_by_user_id current_user if user_signed_in?


    # respond_to method enables an to send different responses
    # based on the type of format requested.
    # The format is interpreted from the last part of a URL.
    # In `/question/10.json` <- the format is JSON.
    # In `/question/10.xml` <- the format is XML.
    # By default, the format is always set to HTML.
    respond_to do |format|
      format.html { render }
      # When using `render` with the json: argument,
      # the given model instance will converting to
      # json using the method `to_json`
      format.json { render json: @question }
    end
   end

  def edit
  end

  def update
    @question.slug = nil

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



  private

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
    #require will extract a nested hash from the params by its keys name
    params.require(:question).permit(:title, :body, :image, tag_ids: [])

  end

  def authorize_user!
    unless can?(:manage, @question)
      flash[:alert] = 'Access Denied!'
      redirect_to question_path(@question)
    end
  end


end
