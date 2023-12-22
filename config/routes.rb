Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  scope '/v1' do
    resources :countries, only: [] do
      get :map, on: :collection
    end
  end

  # Defines the root path route ("/")
  root to: proc { [200, {}, ['success']] }
  match '*path', via: :all, to: proc { [404, {}, nil] }
end
