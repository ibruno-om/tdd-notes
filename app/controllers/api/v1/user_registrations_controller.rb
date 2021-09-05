# frozen_string_literal: true

module Api
  module V1
    class UserRegistrationsController < ApplicationController
      def create
        @user = User.new(registration_params)
        @user.save!
        render json: @user, status: :created
      rescue ActiveRecord::RecordInvalid
        render_json_validation_error(user)
      end

      private

      def registration_params
        params.require(:data).require(:attributes)
              .permit(:name, :email, :password, :avatar) ||
          ActionController::Parameters.new
      end
    end
  end
end
