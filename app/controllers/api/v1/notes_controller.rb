# frozen_string_literal: true

module Api
  module V1
    class NotesController < ApplicationController
      include Api::Paginable
      include Api::Authenticable

      before_action :authenticate!

      before_action :set_note, only: %I[show destroy update]
      before_action :set_user_notes, only: :index
      # GET api/v1/notes
      def index
        render json: @notes, each_serializer: NoteSerializer
      end

      # GET api/v1/notes/:id
      def show
        render json: @note
      end

      # POST api/v1/notes
      def create
        @note = Note.create!(note_params.merge(user: current_user))
        render json: @note, status: :created
      end

      # DELETE api/v1/notes/:id
      def destroy
        @note.destroy!
        render json: nil, status: :accepted
      end

      # PATCH/PUT api/v1/notes/:id
      def update
        @note.update!(note_params)
        render json: @note
      end

      private

      # Permited params for note
      def note_params
        params.require(:data).require(:attributes)
              .permit(:title, :content, :color, :archived, images: [])
      end

      # Set note by ID or return not found status
      def set_note
        @note = current_user.notes.find(params[:id])
      end

      def set_user_notes
        query = params[:query]
        @notes = if query.present?
                   Note.search query, where: { user_id: current_user&.id }, page: page_number, per_page: per_page
                 else
                   current_user&.notes.then(&paginate)
                 end
      end
    end
  end
end
