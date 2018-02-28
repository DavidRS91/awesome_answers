class JobPostsController < ApplicationController
before_action :authenticate_user!, only: [:new,:create, :destroy]
def new
  @job_post = JobPost.new
end

def create
  @job_post = JobPost.new job_post_params
  @job_post.user = current_user
  if @job_post.save
    flash[:notice] = 'Job Created!'
    redirect_to job_post_path(@job_post)
  else
    render :new
  end
end

def edit
  @job_post = JobPost.find params[:id]
end

def update

  @job_post = JobPost.find params[:id]
  if @job_post.update job_post_params
    redirect_to job_post_path(@job_post)
  else
    flash[:alert] = "Invalid Request!"
    render :edit
  end
end

def show
  @job_post = JobPost.find params[:id]

end

def destroy
  @job_post = JobPost.find params[:id]
  @job_post.destroy

  flash[:alert] = "Job Post Deleted"
  redirect_to job_posts_path
end


private

def job_post_params
  params.require(:job_post)
    .permit(
      :title,
      :description,
      :company,
      :role,
      :salary_min,
      :salary_max,
      :location
    )
end

end
