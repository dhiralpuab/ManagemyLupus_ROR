Rails.application.routes.draw do
  # Survey routes
  post "survey/save", to: "survey#save", as: :survey_save
  get  "survey/next", to: "survey#next", as: :survey_next


  # Main app routes
  root "home#index"
  get "/slides", to: "slides#index"
end
