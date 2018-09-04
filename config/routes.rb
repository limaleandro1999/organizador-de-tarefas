Rails.application.routes.draw do
  resources :tarefas
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "tarefas#index"
end
