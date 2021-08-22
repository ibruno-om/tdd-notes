# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationController', type: :controller do
  controller do
    def show
      raise ActiveRecord::RecordNotFound
    end

    def create
      @note = Note.new
      render_json_validation_error(@note)
    end
  end

  describe 'Handling Not Found exceptions' do
    subject { get :show, params: { id: 0 } }

    it_behaves_like 'record_not_found_requests'
  end

  describe 'Handle json api error message properly' do
    before do
      error = ActiveModel::Errors.new(Note.new).tap { |e| e.add(:title, "can't be blank") }
      allow_any_instance_of(Note).to receive(:errors).and_return(error)
    end

    subject { post :create }

    it_behaves_like 'jsonapi_error_entity_requests'
  end
end
