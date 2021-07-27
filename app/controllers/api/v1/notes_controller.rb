# frozen_string_literal: true

module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_paginate, only: :index
      before_action :set_note, only: %I[show destroy update]
      # GET api/v1/notes
      def index
        render json: Note.page(@page).per(@per_page).all
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
          render json: { message: 'Note not created', errors: @note.errors },
                 status: :unprocessable_entity
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
          render json: { message: 'Note not updated', errors: @note.errors },
                 status: :unprocessable_entity
        end
      end

      private

      # Permited params for note
      def note_params
        params.require(:note).permit(:title, :content, :color, :archived)
      end

      # Set note by ID or return not found status
      def set_note
        @note = Note.find(params[:id])
      end

      # Set paginate params
      def set_paginate
        @page = params[:page] || 1
        @per_page = params[:size] || 10
      end
    end
  end
end
