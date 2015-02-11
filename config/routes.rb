Rails.application.routes.draw do
resources :cats
resources :users
resources :cat_rental_requests do
  patch '/deny' => 'cat_rental_requests#deny'
  patch '/approve' => 'cat_rental_requests#approve'
end

resource :session, :only => [:new, :create, :destroy]


end
