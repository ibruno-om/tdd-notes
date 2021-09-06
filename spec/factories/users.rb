# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { valid_user_password }
  end
end

private

def valid_user_password
  "#{password_requirements}#{Faker::Internet.password(min_length: 4,
                                                      max_length: 20,
                                                      mix_case: true,
                                                      special_characters: true)}"
end

# Faker::Internet.password eventually generates a password
# without uppercase letter, lowercase letter, number or special character.
# This method is used to fix that
def password_requirements
  [[*('A'..'Z')].sample, [*('a'..'z')].sample, [*('0'..'9')].sample, (('!'..'?').to_a - ('0'..'9').to_a).sample].shuffle.join
end
