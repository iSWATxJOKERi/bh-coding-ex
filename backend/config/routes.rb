Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api, default: { format: :json } do
    resources :diagnostic_screener_answers, only: [:create] do
      collection do
        get :get_diagnostic_screener
      end
    end
  end
end
