Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :questions do
  resources :answers, only: [:create,:destroy], shallow: true
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
