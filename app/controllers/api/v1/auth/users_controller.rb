require "#{Rails.root}/lib/jwtauth.rb"

module Api
  module V1
    module Auth
      class UsersController < ApplicationController

        before_action :authenticate_user, :only => [:edit_user]

        # POST /register/
        def register
          @user = User.new(auth_params)
          if(@user.save)
            render json: {"message": "User registered successfully!"}, status: 200
          else
            render json: {"message": "User not registered due to the following errors: " + user.errors.full_messages.join(", ")}, status: 400
          end
        end

        # POST /login/
        def login
          user = User.find_by("email": auth_params[:email])
          if(user and user.authenticate(auth_params[:password]))
            render json: {
              "message": "login successful",
              "token": JwtAuth.encode({:sub => user.id})
              }, status: 200
          else
            render json: {"message": "User not found"}, status: 401
          end
        end

        # PUT /edit_user/
        def edit_user
          user = User.find(@current_user)
          if(auth_params[:email].present?)
            render json: {"message": "Update NOT successfull: The email cannot be changed"}, status: 400
          else
            if(auth_params[:password].blank?)
              render json: {"message": "Update NOT successfull: The password cannot be empty"}, status: 400
            else
              if(user.update_attributes(auth_params))
                render json: {"message": "Update successfull " + user.errors.full_messages.join(", ")}, status: 200
              else
                render json: {"message": "Update NOT successfull: " + user.errors.full_messages.join(", ")}, status: 400
              end
            end
          end
        end

        # POST /reset_password/
        def reset_password
          user = User.find_by("email": auth_params[:email])
          if(user)
            render json: {"message": "User found", "Password reset link": "http://www.andela.com"}, status: 200
          else
            render json: {"message": "User not found"}, status: 400
          end
        end

        private def auth_params
          params.permit(:name, :email, :password, :password_confirmation)
        end

      end
    end
  end
end
