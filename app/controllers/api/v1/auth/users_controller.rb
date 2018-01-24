require "#{Rails.root}/lib/jwtauth.rb"

module Api
  module V1
    module Auth
      class UsersController < ApplicationController

        before_action :authenticate_user, :except => [:register, :login, :reset_password]

        # POST /register/
        def register
          @user = User.new(reg_params)
          if(@user.save)
            render json: {"message": "User registered successfully!"}, status: 200
          else
            render json: {"message": "User not registered due to the following errors: " + user.errors.full_messages.join(", ")}, status: 400
          end
        end

        # POST /login/
        def login
          user = User.find_by("email": reg_params[:email])
          if(user and user.authenticate(reg_params[:password]))
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
          if(reg_params[:email].present?)
            render json: {"message": "Update NOT successfull: The email cannot be changed"}, status: 400
          else
            if(reg_params[:password].blank?)
              render json: {"message": "Update NOT successfull: The password cannot be empty"}, status: 400
            else
              if(user.update_attributes(reg_params))
                render json: {"message": "Update successfull " + user.errors.full_messages.join(", ")}, status: 200
              else
                render json: {"message": "Update NOT successfull: " + user.errors.full_messages.join(", ")}, status: 400
              end
            end
          end
        end

        # POST /reset_password/
        def reset_password
          user = User.find_by("email": reg_params[:email])
          if(user)
            render json: {"message": "User found", "Password reset link": "http://www.andela.com"}, status: 200
          else
            render json: {"message": "User not found"}, status: 400
          end
        end

        private def reg_params
          params.permit(:name, :email, :password, :password_confirmation)
        end

        private def authenticate_user
          auth_header = request.headers[:Authorization]
          if(auth_header)
            token = auth_header.split(" ").last
            if (token)
              user = JwtAuth.decode(token)
              if user
                  @current_user ||= user['sub']
              else
                render json: {"message": "Access denied. Invalid login credentials. Please log in again"}, status: 401
              end
            else
              render json: {"message": "Invalid token"}, status: 401
            end
          else
            render json: {"message": "Access denied. Please log in"}, status: 401
          end
        end

      end
    end
  end
end
