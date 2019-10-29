Rails.application.routes.draw do
  resources :cats do
    resources :cat_rental_requests, only: [:show, :index, :create]
  end

  resources :cat_rental_requests do
    member do
      get 'approve'
    end

    member do
      get 'deny'
    end
  end

  root to: redirect("/cats")
end
