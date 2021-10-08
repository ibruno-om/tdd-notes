# frozen_string_literal: true

module Api
  module V1
    class SharingsController < ApplicationController
      include Api::Authenticable
      before_action :authenticate!

      before_action :set_note, only: %I[index create update destroy]
      # GET notes/:note_id/sharings/
      def index
        render json: @note.sharings
      end

      # POST notes/:note_id/sharings/
      def create
        render json: @note.sharings.create!(sharing_params), status: :ok
      end

      private

      # Permited params for sharing
      def sharing_params
        params.require(:data).require(:attributes)
              .permit(:user_id, :permission)
      end

      # Set note by ID or return not found status
      def set_note
        @note = current_user.notes.find(params[:note_id])
      end
    end
  end
end
