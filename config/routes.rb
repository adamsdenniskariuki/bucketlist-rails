Rails.application.routes.draw do

namespace 'api' do
  namespace 'v1' do
    namespace 'auth' do
      post '/register', to: 'users#register'
      post '/login', to: 'users#login'
      put '/edit_user', to: 'users#edit_user'
      post '/reset_password', to: 'users#reset_password'
    end
  end
end


end
