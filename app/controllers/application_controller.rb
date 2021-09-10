# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
  rescue_from ActiveRecord::RecordNotDestroyed, with: :render_record_not_destroyed

  private

  # Handle not found error response
  def render_record_not_found
    render json: NOT_FOUND_RESPONSE, status: :not_found
  end

  # Handle invalid record error response
  def render_invalid_record(exception)
    render_json_validation_error(exception.record)
  end

  # Handle record not destroyed response
  def render_record_not_destroyed(exception)
    render_json_validation_error(exception.record)
  end

  # Handle validation resource error
  def render_json_validation_error(resource)
    render json: resource, status: :unprocessable_entity, adapter: :json_api, serializer: JsonValidationErrorSerializer
  end
end
