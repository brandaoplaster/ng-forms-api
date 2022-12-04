require "api_version_constraint"

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1, contraints: ApiVersionConstraint.new(version: 1, default: true) do
      mount_devise_token_auth_for "User", at: "auth/user"
    end
  end
end
