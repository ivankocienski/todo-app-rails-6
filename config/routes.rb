Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#root'
  get '/about' => 'home#about'

  resources :todo_items
  resources :todo_lists
end
