Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root 'home#root'
    get '/about' => 'home#about'

    resources :todo_lists do
        resources :todo_items, only: %i[show new edit update create]
    end

    resources :aspirations

    resources :progress_logs, only: %i[index show new create]
end
