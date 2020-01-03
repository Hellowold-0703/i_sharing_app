FactoryBot.define do
  factory :place do
    id {"1"}
    title {"常総市役所"}
    address {"常総市役所"}
    latitude {"36.0235"}
    longitude {"139.994"}
    description {"勤務先です"}
    user_id {"1"}
    likes_count {"1"}
    created_at {"2019-12-18 02:01:20"}
    updated_at {"2019-12-18 02:01:20"}
    association :user, factory: :user
    after(:build) do |place|
      place.images<< build(:image, place: place)
    end
  end
end