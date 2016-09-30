FactoryGirl.define do
  # When calling auth_hash, use one of the traits listed below for a
  # facebook user, google user or when testing a user who does not
  # persist, use the does_not_persist trait.
  factory :auth_hash, class: OmniAuth::AuthHash do

    initialize_with do
      OmniAuth::AuthHash.new({
        provider: 'facebook',
        uid: '12345',
        info: {
          email: "testuser@facebook.com"
        },
        extra: {
            raw_info: {
              name: "mockuser"
          }
        }
      })
    end

    trait :facebook do
      provider "facebook"
      sequence(:uid)
      email "testuser@facebook.com"
    end

    trait :does_not_persist do
      email ""
    end

  end
end