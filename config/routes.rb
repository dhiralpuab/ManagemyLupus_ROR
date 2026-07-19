Rails.application.routes.draw do
  # Admin routes
  namespace :admin do
    resources :cards, only: [:index] do
      collection do
        get :login
        post :do_login
        get :logout
        get :history
        get "preview_version", to: "cards#preview_version"
        post "restore_version", to: "cards#restore_version"
        delete "delete_version", to: "cards#delete_version"
      end
    end
    get "cards/:id/edit", to: "cards#edit", as: :edit_card
    patch "cards/:id", to: "cards#update", as: :update_card
    delete "cards/:id", to: "cards#destroy", as: :delete_card
    get "cards/new/:category", to: "cards#new", as: :new_card
    post "cards/create/:category", to: "cards#create", as: :create_card

    resources :images, only: [:index, :create, :destroy] do
      member do
        get :usage
      end
    end
  end

  # Turbo Native configuration endpoint
  namespace :turbo do
    get "native/configuration", to: "native#configuration"
  end

  # Card details for deep linking and native modals
  resources :cards, only: [:show]

  # Survey routes
  post "survey/save", to: "survey#save", as: :survey_save
  get  "survey/next", to: "survey#next", as: :survey_next

  # Main app routes
  root "home#index"
  get "/slides", to: "slides#index"

  # PWA routes
  get "/offline", to: "pwa#offline"
  get "/manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "/service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
