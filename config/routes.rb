Rails.application.routes.draw do
  resources :users, only: %i[create index show]
end
