Rails.application.routes.draw do
  mount Ijust::API => '/api'

  mount_ember_app :frontend, to: "/"
end
