# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # Handle not found error and response
  def record_not_found
    render json: { status: '404', error: 'Record not found' }, status: :not_found
  end
end
