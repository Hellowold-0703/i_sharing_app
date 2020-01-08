require 'rails_helper'

RSpec.feature "Places", type: :feature do
  
  scenario "user creates a new place" do
    
    user = FactoryBot.create(:user)
    
    visit root_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "Log in"

    expect {
      click_link "投稿する"
      expect(current_path).to eq new_place_path
      attach_file "place[images_attributes][0][image]", "#{Rails.root}/spec/fixtures/test.jpg"
      fill_in "タイトル", with: "常総市役所"
      fill_in "住所・施設名", with: "常総市役所"
      fill_in "説明", with: "人口６万人の小さい町です"
      click_button "投稿する"
      expect(page).to have_content "相手のことを考え丁寧なコメントを心がけましょう。"
    }.to change(Place, :count).by(1)
  end
end
