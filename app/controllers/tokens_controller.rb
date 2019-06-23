class TokensController < ApplicationController
  before_action :authorize_request, except: :generate_token
  
  def generate_token
    token = JsonWebToken.encode({request: :autorized})

    render json: {token: token}, status: :ok
  end
end
