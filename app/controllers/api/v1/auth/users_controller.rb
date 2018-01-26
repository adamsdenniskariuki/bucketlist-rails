module Api
  module V1
    module Auth
      class UsersController < ApplicationController

        before_action :authenticate_user, :only => [:edit_user]

        # POST /register/
        def register
          user = User.new(auth_params)
          if(user.save)
            render json: {"message": Messages.registration_successful}, status: 201
          else
            render json: {"message": "" + Messages.registration_failed(user.errors.full_messages)}, status: 422
          end
        end

        # POST /login/
        def login
          user = User.find_by("email": auth_params[:email])
          if(user and user.authenticate(auth_params[:password]))
            render json: {
              "message": Messages.login_successful,
              "token": JwtAuth.encode({:sub => user.id})
              }, status: 200
          else
            render json: {"message": Messages.login_failed}, status: 401
          end
        end

        # PUT /edit_user/
        def edit_user
          user = User.find(@current_user)
          if(auth_params[:email].present?)
            render json: {"message": Messages.update_email_failure}, status: 422
          else
            if(auth_params[:password].blank?)
              render json: {"message": Messages.update_invalid_password}, status: 422
            else
              if(user.update_attributes(auth_params))
                render json: {"message": Messages.update_successful}, status: 200
              else
                render json: {"message": Messages.update_failed(user.errors.full_messages)}, status: 422
              end
            end
          end
        end

        # POST /reset_password/
        def reset_password
          user = User.find_by("email": auth_params[:email])
          if(user)
            render json: {"message": Messages.password_reset_user_found, "link": "http://www.andela.com"}, status: 200
          else
            render json: {"message": Messages.password_reset_user_not_found}, status: 422
          end
        end

        private def auth_params
          params.permit(:name, :email, :password, :password_confirmation)
        end

      end
    end
  end
end
