# frozen_literal_string: true
module Api
  module Paginable
    extend ActiveSupport::Concern

    included do
      def default_per_page
        10
      end

      def page_number
        params[:page] || 1
      end

      def per_page
        params[:per_page] || default_per_page
      end

      def paginate
        ->(it) { it.page(page_number).per(per_page) }
      end
    end
  end
end
