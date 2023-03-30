Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :expenses
  get 'show_report', to: 'expenses#show_report', as: 'show_report'
  post 'show_report', to: 'expenses#show_report', as: 'generate_report'
  # Defines the root path route ("/")
  # root "articles#index"
  root to: "expenses#index"
end
