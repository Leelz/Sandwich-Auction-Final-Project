Rails.application.routes.draw do

  resources :orders do 
    resources :orderedsandwiches
  end

end
