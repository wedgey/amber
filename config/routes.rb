Rails.application.routes.draw do
  
  resources :dashboard, only: [:show]
  get 'report', to: 'report#index'

  resources :sessions, only: [:new, :create, :destroy]

  get 'user/farms', to: 'farms#user_show'
  post '/weather/forecast', to: 'weather_logs#get_weather'
  # get 'user/report', to: 'report#show'

  resources :weather_logs
  resources :sub_farm_activities
  resources :stocks
  resources :resources
  
  resources :crops
  resources :farms do
    resources :sub_farms
  end

  resources :users

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
