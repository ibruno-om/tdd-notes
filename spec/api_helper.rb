# frozen_string_literal: true

module ApiHelper
  # Helper method to parse a response
  #
  # @return [Hash]
  def json_response
    JSON.parse(response.body)
  end
end
