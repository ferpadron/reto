# frozen_string_literal: true

Rails.application.routes.draw do
  root 'api/v1/fedex_quotes#index', defaults: { format: :json }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :fedex_quotes, only: %i[index]
      resources :clients, only: %i[index]
    end
  end
end
