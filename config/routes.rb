SimpleBbs::Application.routes.draw do
  devise_for :users

  resources :users, only: [:show] do
    get :topics, on: :member
  end

  resources :topics, only: [:index, :show, :new, :create, :edit, :update] do
    resources :replies, only: [:create, :edit, :update, :destroy]
  end

  resources :nodes, only: [:show]

  root to: "topics#index"

  get "ui/:action" => "ui"
end
