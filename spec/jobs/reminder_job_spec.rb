require 'rails_helper'

RSpec.describe ReminderJob, type: :job do
  let(:reminder) { create(:reminder) }

  describe '#perform_later' do
    it 'schedule reminder' do
      expect do
        ReminderJob.perform_later(id: reminder.id)
      end.to have_enqueued_job.with({ id: reminder.id })
    end

    describe '#set :wait_until' do
      it 'schedule reminder' do
        expect do
          ReminderJob.set(wait_until: Date.tomorrow.noon).perform_later({ id: reminder.id })
        end.to have_enqueued_job.with({ id: reminder.id }).on_queue(:reminders).at(Date.tomorrow.noon)
      end
    end

    describe '#perform' do
      it 'schedule reminder' do
        ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
        ReminderJob.perform_later({ id: reminder.id })
        expect(ReminderJob).to have_been_performed
      end
    end
  end
end
