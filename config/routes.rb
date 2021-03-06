Homebugh::Application.routes.draw do
  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api/graphql"
  post "/api/graphql", to: "graphql#execute"

  resources :transactions, :cash_flows, only: [:index, :new, :create, :update, :destroy]
  resources :categories, :accounts, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :statistics, only: [:index] do
    get :archived, on: :collection
  end
  resources :budgets

  devise_for :users

  authenticated :user do
    root to: "transactions#index", as: :auth_root
  end

  post "/api/token" => "api/token#create"

  root to: "welcome#index"
end
