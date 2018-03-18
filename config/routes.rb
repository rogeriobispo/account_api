Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :account_transactions, only: [:create, :show] do
          get 'revert', on: :member
      end

      post '/aport/revert', to: 'aport#revert'
      resources :aport, only: [:create, :show] do
      end
    end
  end
end
