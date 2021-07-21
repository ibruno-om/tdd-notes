# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_note, only: %I[index]

      # GET notes/:note_id/items/
      def index
        render json: @note.items
      end

      private

      # Set note by ID or return not found status
      def set_note
        @note = Note.find(params[:note_id])
      end
    end
  end
end
