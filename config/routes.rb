Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  resources :wallets, only: %i[create show index] do
    resources :transactions, only: :create do
      collection do
        post :spend_points
      end
    end
  end
end
