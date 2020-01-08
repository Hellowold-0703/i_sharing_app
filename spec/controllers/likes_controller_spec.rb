require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  
  let(:user) { FactoryBot.create(:user) }
  let(:place) { FactoryBot.create(:place) }
  let(:like) { FactoryBot.create(:like, user_id: user.id, place_id: place.id) }

  describe "#create" do
    
    it "responds with ajax formatted output" do
      sign_in user
      post :like, format: :js,
      params: { id: like.id, place_id: place.id }
      expect(response.content_type).to eq "text/javascript"
    end

    it "add a new like to the place" do
      sign_in user
      expect {
      post :like, format: :js, params: { id: like.id, place_id: place.id }
      }.to change(Like, :count).by(1)
    end
  end
  
  describe "#destroy" do
    
    it "responds with ajax formatted output" do
      sign_in user
      delete :unlike, format: :js,
      params: {id: like.id, place_id: place.id, user_id: user.id }
      expect(response.content_type).to eq "text/javascript"
    end

    it "remove a like to the place" do
      sign_in user
      like
      expect {
      delete :unlike, format: :js, params: { id: like.id, place_id: place.id, user_id: user.id}
      }.to change(Like, :count).by(-1)
    end
  end
end
