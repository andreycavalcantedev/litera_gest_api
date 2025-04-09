class ApplicationController < ActionController::API
  before_action :authenticate_request
  
  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)

    if decoded
      @current_user = User.find_by(id: decoded[:user_id])
    end

    render json: { error: 'Não autorizado' }, status: :unauthorized unless  @current_user
  end
end
