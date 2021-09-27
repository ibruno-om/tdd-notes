# frozen_string_literal: true

module Api
  module V1
    class ItemsController < ApplicationController
      include Api::Authenticable

      before_action :authenticate!
      before_action :set_note, only: %I[index create update destroy]
      before_action :set_item, only: %I[update destroy]

      # GET notes/:note_id/items/
      def index
        render json: @note.items
      end

      # POST notes/:note_id/items/
      def create
        render json: @note.items.create!(item_params), status: :ok
      end

      # PUT/PATCH notes/:note_id/items/:id
      def update
        @item.update!(item_params)
        render json: @item, status: :ok
      end

      # DELETE notes/:note_id/items/:id
      def destroy
        @item.destroy!
        render json: nil, status: :accepted
      end

      private

      # Permited params for item
      def item_params
        params.require(:data).require(:attributes)
              .permit(:description)
      end

      # Set item by ID or return not found status
      def set_item
        @item = @note.items.find(params[:id])
      end

      # Set note by ID or return not found status
      def set_note
        @note = current_user.notes.find(params[:note_id])
      end
    end
  end
end
