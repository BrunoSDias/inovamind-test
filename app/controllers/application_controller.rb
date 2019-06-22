class ApplicationController < ActionController::API
    def authorize_request
      header = request.headers['Authorization']
      begin
        debugger
        @decoded = JsonWebToken.decode(header)
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end
end
