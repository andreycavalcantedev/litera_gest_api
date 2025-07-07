class ApplicationController < ActionController::API
  before_action :authenticate_request

  def current_user
    @current_user
  end

  def current_library
    @current_library
  end

  
  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
      if @current_user && @current_user&.type_user_id.present?
        @current_library = Library.find_by(id: @current_user.library_id)
      end
    end

    if BlackListedToken.exists?(token: header)
      return render json: { errors: 'Invalid token' }, status: :unauthorized
    end

    return render json: { error: 'Unauthorized' }, status: :unauthorized unless  @current_user
  end
end
