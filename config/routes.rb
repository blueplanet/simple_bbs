SimpleBbs::Application.routes.draw do

  get "topics/index"
  root to: "topics#index"

  get "ui/:action" => "ui"
end
