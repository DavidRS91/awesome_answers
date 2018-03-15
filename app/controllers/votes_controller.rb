class VotesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_vote, only: [:destroy, :update]

   def create
     answer = Answer.find params[:answer_id]
     vote = Vote.new(
       user: current_user,
       answer: answer,
       is_up: params[:is_up]
     )

     if !vote.save
       flash[:alert] = vote.errors.full_messages.join(', ')
     end
     redirect_to question_path(answer.question)
   end

   def update
     if !@vote.update(is_up: params[:is_up])
       flash[:alert] = @vote.errors.full_messages.join(', ')
     end
     redirect_to question_path(@vote.answer.question)
   end

   def destroy
     @vote.destroy

     redirect_to question_path(@vote.answer.question)
   end

  private

  def find_vote
    @vote = Vote.find params[:id]

  end

end
