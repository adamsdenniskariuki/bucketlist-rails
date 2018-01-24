class ApplicationController < ActionController::API

  # method to authenticate user tokens
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
