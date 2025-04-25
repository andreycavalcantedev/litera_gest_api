class AuthController < ApplicationController
  skip_before_action :authenticate_request

  def logout 
    token = request.headers['Authorization']&.split(' ')&.last
    BlackListedToken.create(token: token) if token
    render json: { message: 'Logout realizado com sucesso' }, status: :ok
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: 'Credenciais inválidas' }, status: :unauthorized
    end
  end
end
