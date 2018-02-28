require 'rails_helper'

RSpec.describe JobPostsController, type: :controller do

 let(:user) { FactoryBot.create :user }

  describe '#new' do

    context 'with no user signed in' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with user signed in' do
      before do
        user = FactoryBot.create :user
        request.session[:user_id] = user.id
      end
      it 'renders the new template' do

        # GIVEN: defaults

        # WHEN: Making a get request to /new
        get :new
        #☝🏻Use any of the methods named after http verbs to simulatae a request
        #These methods take a first arg that is a symbol named an action

        # THEN: Expect that response will contain the HTML for the new template
        expect(response).to render_template(:new)

      end

      it 'sets an instance variable with a new job post' do
        get :new
        expect(assigns(:job_post)).to be_a_new(JobPost)
        #assigns(:job_post) will return an instance variable, if it was declared inside the  job posts controller
        #be_a_new is an rspec matcher that will check that a given object is a new record of a passed in class (ie not saved to db)
      end
    end
  end

  describe '#create' do
    context 'with no user signed in' do
      it 'redirects to the new session path' do
        post :create, params: { job_post: FactoryBot.attributes_for(:job_post) }
        expect(response).to redirect_to(new_session_path)
      end
    end
    context 'with user signed in' do
      before do
        @user = FactoryBot.create :user
        request.session[:user_id] = @user.id
      end
      context 'with valid parameters' do
        def valid_request
          post :create, params: {
            job_post: FactoryBot.attributes_for(:job_post)
          }
        end

        it 'creates a new job post in the db' do
          count_before = JobPost.count
          valid_request
          count_after = JobPost.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirect to the shopw pages of that job post' do
          valid_request
          expect(response).to redirect_to(job_post_path(JobPost.last))
        end

        it 'sets a flash message' do
          valid_request
          expect(flash[:notice]).to be
        end
        it 'associates the post with a logged in user' do
          valid_request
          expect(JobPost.last.user).to eq(@user)
        end
      end
      context 'with invalid parameters' do
        def invalid_request
          post :create, params: {
            # When using any factory methods (e.g attributes_for,
            # build, create), you can replace any attribute by
            # adding key-value arguments.
            # In the code below, the "title" of the created
            # JobPost attributes will be replaced by "".
            job_post: FactoryBot.attributes_for(:job_post, title: "")
          }
        end

        it "doesn't create a job post in the database" do
          count_before = JobPost.count
          invalid_request
          count_after = JobPost.count

          expect(count_after).to eq(count_before)
        end

        it "renders the new template" do
          invalid_request
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe '#show' do
    it 'renders the show template' do
      job_post = FactoryBot.create :job_post
      get :show, params: { id: job_post.id }
      expect(response).to render_template(:show)
    end
    it 'assigns a record to job post whose id is in the params' do
      job_post = FactoryBot.create :job_post
      get :show, params: { id: job_post.id }

      expect(assigns(:job_post)).to eq(job_post)
    end
  end

  describe '#destroy' do
    def valid_request
      @job_post = FactoryBot.create :job_post
      delete :destroy, params: { id: @job_post.id }
    end
    context 'with user_signed_in' do
      before { request.session[:user_id] = user.id }
      it 'removes record from db' do
        job_post = FactoryBot.create :job_post
        count_before = JobPost.count
        delete :destroy, params: {id: job_post.id}
        count_after = JobPost.count
        expect(count_after).to eq(count_before - 1)
      end
      it 'redirects to the index' do
        valid_request
        expect(response).to redirect_to(job_posts_path)
      end
      it 'alerts the user with a flash' do
        valid_request
        expect(flash[:alert]).to be
      end
    end
  end

  describe '#edit' do
    before do
    @job_post = FactoryBot.create :job_post
    get :edit, params: {id: @job_post.id}
    end
    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
    it 'assigns an instance variable to job post whose id was passed' do
      expect(assigns(:job_post)).to eq(@job_post)
    end
  end

  describe '#update' do
    context 'with valid params' do
      before do
        # GIVEN: we have a post in the db
        @job_post = FactoryBot.create :job_post

        # WHEN: send patch request with id of job post
        patch :update, params: { id: @job_post.id,
                                 job_post: {title: 'new_valid_title'}
                               }
      end

      it 'updates job post with new data' do
        expect(@job_post.reload.title).to eq('new_valid_title')
      end
      it 'redirects to the job post show page' do
        expect(response).to redirect_to(job_post_path(@job_post))
      end
    end
    context 'with invalid params' do
      it 'has flash message'
      it 'renders the edit template'
    end
  end

end
