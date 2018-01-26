Rails.application.routes.draw do

namespace 'api' do
  namespace 'v1' do
    namespace 'auth' do
      post '/register', to: 'users#register', as: 'register'
      post '/login', to: 'users#login', as: 'login'
      put '/edit_user', to: 'users#edit_user', as: 'edit_user'
      post '/reset_password', to: 'users#reset_password', as: 'reset_password'
    end

    namespace 'bucketlists' do
      post '/', to: 'todos#create_bucketlist', as: 'create_bucketlist'
      get '/', to: 'todos#view_all_bucketlists', as: 'view_all_bucketlists'
      get '/:id', to: 'todos#view_single_bucketlist', as: 'view_single_bucketlist'
      put '/:id', to: 'todos#edit_bucketlist', as: 'edit_bucketlist'
      delete '/:id', to: 'todos#delete_bucketlist', as: 'delete_bucketlist'

      post '/:id/items', to: 'items#create_item', as: 'create_item'
      get '/:id/items', to: 'items#view_all_items', as: 'view_all_items'
      get '/:id/items/:item_id', to: 'items#view_single_item', as: 'view_single_item'
      put '/:id/items/:item_id', to: 'items#edit_item', as: 'edit_item'
      delete '/:id/items/:item_id', to: 'items#delete_item', as: 'delete_item'
    end
  end
end


end
