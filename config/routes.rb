Rails.application.routes.draw do
  get 'welcome/index'

  resources :weather_logs
  resources :sub_farm_activities
  resources :stocks
  resources :resources
  resources :sub_farms
  resources :crops
  resources :farms
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'farms#index'
end
