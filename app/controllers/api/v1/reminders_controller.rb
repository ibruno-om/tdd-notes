# frozen_literal_string: true

module Api
  module V1
    class RemindersController < ApplicationController
      include Api::Authenticable
      before_action :authenticate!

      before_action :set_note, only: %I[show create destroy]

      # GET notes/:note_id/reminders/
      def show
        render json: @note.reminder
      end

      # POST notes/:note_id/reminders/
      def create
        render json: @note.create_reminder!(reminder_params), status: :ok
      end

      # DELETE notes/:note_id/reminders/
      def destroy
        @note.reminder.destroy! if @note.reminder.present?
        render json: nil, status: :accepted
      end

      private

      # Permited params for reminder
      def reminder_params
        params.require(:data).require(:attributes)
              .permit(:notification_time)
      end

      # Set note by ID or return not found status
      def set_note
        @note = current_user.notes.find(params[:note_id])
      end
    end
  end
end
