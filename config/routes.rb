Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do #namespace method takes a symbol for the first arg and a block, it will prefix the path of all routes defined within the block with the symbols name
    resources :dashboard, only: [:index]
    # eg. admin/dashboard
    #it will expect that the controllers for the routes inside block will be contained in a module after the symbol
    #it will also expect the controllers to be in sub-directories named after the symbol

  end

  resources :job_posts, only: [:new, :create, :show, :destroy, :edit, :update]

  resource :session, only: [:new, :create, :destroy]
  # ☝🏻 Notice that resource is singular, unlike resources,
  # a resource will create routes that are meant to do
  # CRUD on a single thing. There will be no index route
  # or any route with :id
  resources :users, only: [:new, :create]
  resources :questions, shallow: true do
    resources :answers, only: [:create,:destroy]
    resources :likes, only:  [:create,:destroy]
  end

  # get('/questions/new', to: 'questions#new', as: :new_question)
  # post('/questions', to: 'questions#create', as: :questions)
  # get('/questions', to: 'questions#index')
  # get('/questions/:id', to: 'questions#show', as: :question)
  # get('/questions/:id/edit', to: 'questions#edit', as: :edit_question)
  # patch('/questions/:id', to: 'questions#update')
  # put('/questions/:id', to: 'questions#update')
  # delete('/questions/:id', to: 'questions#destroy')
  #
  get('/',{to: 'welcome#index', as: :root})

  get('/about',{to: 'welcome#about'})

  get('/contact/new', {to: 'contact#new'})
  post('contact/submit', {to: 'contact#create'})

end
