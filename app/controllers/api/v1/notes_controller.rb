# frozen_string_literal: true

module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_paginate, only: [:index]
      before_action :set_note, only: %I[show destroy]
      # GET api/v1/notes
      def index
        render json: Note.page(@page).per(@per_page).all
      end

      # GET api/v1/note
      def show
        render json: @note
      end

      # POST api/v1/notes
      def create
        @note = Note.new(note_params)
        if @note.save
          render json: @note
        else
          render json: { error: { RecordInvalid: @note.errors } }, status: 406
        end
      end

      # DELETE api/v1/notes
      def destroy
        if @note.destroy
          render json: { success: 'Note deleted' }, status: 202
        else
          render json: { error: 'Note not deleted' }, status: 406
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
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Not found' }, status: 404
      end

      # Set paginate params
      def set_paginate
        @page = params[:page] || 1
        @per_page = params[:size] || 10
      end
    end
  end
end
