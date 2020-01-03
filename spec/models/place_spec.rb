require 'rails_helper'

RSpec.describe Place, type: :model do

  it "is valid with a title, address, latitude, longitude, description, images" do
    place = FactoryBot.build(:place)
    expect(place).to be_valid
  end

  it "is invalid without a title" do
    place = FactoryBot.build(:place, title: nil)
    place.valid?
    expect(place.errors[:title]).to include("を入力してください") 
  end

  it "is invalid without an address" do
    place = FactoryBot.build(:place, address: nil)
    place.valid?
    expect(place.errors[:address]).to include("を入力してください") 
  end

  it "is invalid without a description" do
    place = FactoryBot.build(:place, description: nil)
    place.valid?
    expect(place.errors[:description]).to include("を入力してください")
  end

  it "is invalid without images" do
    place = Place.new(
      title: "常総市役所",
      address: "常総市役所",
      latitude: "36.0235",
      longitude:"139.994",
      description: "勤務先です",
      user_id: 1,
      likes_count: 1,
      created_at: "2019-12-18 02:01:20",
      updated_at: "2019-12-18 02:01:20",
      user: FactoryBot.build(:user)
    )
    place.images<< FactoryBot.build(:image, image: nil)
    place.valid?
    expect(place.images[0].id).to eq nil
  end
end
