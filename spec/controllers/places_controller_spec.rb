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
        expect(response).to be_successful
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
        expect(response).to be_successful
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
        expect { FactoryBot.create(:place)
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
  
  describe "#update" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @place = FactoryBot.create(:place, user: @user)
      end

      it "updates a place" do
        place_params = FactoryBot.attributes_for(:place, title: "常総市")
        sign_in @user
        patch :update, params: {id: @place.id, place: place_params}
        expect(@place.reload.title).to eq "常総市"
      end
    end

    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user, name: "中居正弘")
        @place = FactoryBot.create(:place, user: other_user, title: "つくば市")
      end

      it "does not update the place" do
        place_params = FactoryBot.attributes_for(:place, title: "常総市")
        sign_in @user
        patch :update, params: {id: @place.id, place: place_params}
        expect(@place.reload.title).to eq "つくば市"
      end

      it "redirects to the edit page" do
        place_params = FactoryBot.attributes_for(:place)
        sign_in @user
        patch :update, params: {id: @place.id, place: place_params}
        expect(response).to redirect_to edit_place_path
      end
    end
  end
    
  describe "#update" do
    context "as a guest" do
      before do
        @place = FactoryBot.create(:place)
      end

      it "returns a 302 response" do
        place_params = FactoryBot.attributes_for(:place)
        patch :update, params: {id: @place.id, place: place_params}
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        place_params = FactoryBot.attributes_for(:place)
        patch :update, params: {id: @place.id, place: place_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @place = FactoryBot.create(:place, user: @user)
      end

      it "deletes a place" do
        sign_in @user
        expect{
          delete :destroy, params: {id: @place.id}
        }.to change(Place, :count).by(-1)
      end
    end

    context "as an unauthoerized user" do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user, name: "草彅剛")
        @place = FactoryBot.create(:place, user: other_user)
      end

      it "does not delete the place" do
        sign_in @user
        expect {
          delete :destroy, params: {id: @place.id}
        }.to_not change(Place, :count)
      end

      it "redirects to the dashboard" do
        sign_in @user
        delete :destroy, params: {id: @place.id}
        expect(response).to redirect_to root_path
      end
    end
    
    context "as a guest" do
      before do
        @place = FactoryBot.create(:place)
      end

      it "returns a 302 response" do
        delete :destroy, params: {id: @place.id}
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        delete :destroy, params: {id: @place.id}
        expect(response).to redirect_to "/users/sign_in"
      end

      it "does not delete the place" do
        expect {
          delete :destroy, params: {id: @place.id}
        }.to_not change(Place, :count)
      end
    end
  end
end

