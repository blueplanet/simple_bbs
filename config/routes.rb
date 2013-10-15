SimpleBbs::Application.routes.draw do
  resources :topics, only: [:index, :show]
  resources :nodes, only: [:show]

  root to: "topics#index"

  get "ui/:action" => "ui"
end
