Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :account_transactions, only: [:create, :show] do
          get 'revert', on: :member
      end

      post '/aports/revert', to: 'aports#revert'
      resources :aports, only: [:create, :show]

      resource :account_relations, only: [:create, :destroy]

      resources :clients, only: [:create, :show, :destroy,:update]
    end
  end
end
