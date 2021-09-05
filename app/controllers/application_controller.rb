# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  private

  # Handle not found error and response
  def record_not_found
    render json: NOT_FOUND_RESPONSE, status: :not_found
  end

  # Handle invalid record error and response
  def invalid_record(exception)
    render_json_validation_error(exception.record)
  end

  # Handle validation resource error
  def render_json_validation_error(resource)
    render json: resource, status: :unprocessable_entity, adapter: :json_api, serializer: JsonValidationErrorSerializer
  end
end
