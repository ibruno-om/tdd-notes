# frozen_string_literal: true

module Api
  module V1
    class NotesController < ApplicationController
      include Api::Paginable
      include Api::Authenticable

      before_action :authenticate!

      before_action :set_note, only: %I[show destroy update]
      # GET api/v1/notes
      def index
        render json: Note.all.then(&paginate)
      end

      # GET api/v1/notes/:id
      def show
        render json: @note
      end

      # POST api/v1/notes
      def create
        @note = Note.new(note_params)
        if @note.save
          render json: @note
        else
          render_json_validation_error(@note)
        end
      end

      # DELETE api/v1/notes/:id
      def destroy
        if @note.destroy
          render json: { success: 'Note deleted' }, status: :accepted
        else
          render json: { message: 'Note not deleted' }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT api/v1/notes/:id
      def update
        if @note.update(note_params)
          render json: @note
        else
          render_json_validation_error(@note)
        end
      end

      private

      # Permited params for note
      def note_params
        params.require(:data).require(:attributes)
              .permit(:title, :content, :color, :archived, images: [])
      end

      # Set note by ID or return not found status
      def set_note
        @note = Note.find(params[:id])
      end
    end
  end
end
