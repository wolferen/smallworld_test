class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,
              with: :record_not_found_response

  def record_not_found_response(exception)
    render json: { error: exception.message }, status: 404
  end
end
