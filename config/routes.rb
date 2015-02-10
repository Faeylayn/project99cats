Rails.application.routes.draw do
resources :cats

resources :cat_rental_requests do
  patch '/deny' => 'cat_rental_requests#deny'
  patch '/approve' => 'cat_rental_requests#approve'
end


end
