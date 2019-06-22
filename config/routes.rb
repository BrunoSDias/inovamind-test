Rails.application.routes.draw do
  resources :quotes, only: [:index]
  get '/load', defaults: {format: :json}, to: "quotes#load"
  get 'quotes/:tag_name', to: 'quotes#find_by_tag'
  get '/authorize', to: 'tokens#generate_token'
end
