# frozen_string_literal: true

module ApiHelper
  # Helper method to parse a response
  # @return [Hash]
  def json_response
    JSON.parse(response.body)
  end

  # Helper method to parse a data hash from response
  # @return [Hash]
  def json_response_data
    json_response.deep_symbolize_keys[:data]
  end

  # Helper method to parse a data hash from response to arrays of IDs
  # @return [Array]
  def json_response_data_ids
    json_response_data.map { |item| item[:id] }
  end

  def serialize_model_as_json(model, options: {})
    ActiveModelSerializers::SerializableResource.new(model, options).as_json
  end
end
