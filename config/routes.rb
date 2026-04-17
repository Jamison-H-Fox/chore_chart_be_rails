Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      devise_for :users,
        path: "auth",
        controllers: {
          sessions: "api/v1/auth/sessions",
          registrations: "api/v1/auth/registrations"
        },
        defaults: { format: :json }

      post "auth/sign_up", to: "api/v1/auth/registrations#create"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
