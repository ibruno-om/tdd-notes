# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationController', type: :controller do
  controller do
    def show
      raise ActiveRecord::RecordNotFound
    end
  end

  describe 'Handling Not Found exceptions' do
    subject { get :show, params: { id: 0 } }

    it_behaves_like 'record_not_found_requests'
  end
end
