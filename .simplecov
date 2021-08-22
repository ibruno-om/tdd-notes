# frozen_string_literal: true

SimpleCov.start 'rails' do
  # any custom configs like groups and filters can be here at a central place
  add_group 'Serializers', 'app/serializers' # Matches EE files as well
end
