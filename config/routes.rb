Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :entries, only: [:index, :new, :create] do
    # collection do
    #   get 'create', to: 'entries#create'
    #   post :create
    # end
  end
end
