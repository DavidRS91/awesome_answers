class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    question = Question.find params[:question_id]
    like = Like.new user: current_user, question: question
    if like.save
      redirect_to question, notice: 'Liked!'
    else
      redirect_to question, alert: 'Not Liked!'
    end
  end

  def destroy
    question = Question.find params[:id]
    @like = Like.find params[:id]
    @like.destroy
    redirect_to @like.question
  end

end
