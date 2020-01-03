require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe "#index" do
    context "as an authenticated user" do
    
      before do 
        @user = FactoryBot.create(:user)
      end

      it "responds successfully" do
        sign_in @user
        get :index
        expect(response).to be_success
      end

      it "returns a 200 responds" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do 
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @place = FactoryBot.create(:place)  
      end

      it "responds successfully" do
        sign_in @user
        get :show, params:{ id: @place.id}
        expect(response).to be_success
      end
    end
  end

  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "create a place" do 
        sign_in @user
        expect { 
          FactoryBot.create(:place)
        }.to change(Place, :count).by(1).and change(Image, :count).by(1)
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        
        place_params = FactoryBot.attributes_for(:place)
        post :create, params: {place: place_params}
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign_in page" do
        place_params = FactoryBot.attributes_for(:place)
        post :create, params: {place: place_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end

