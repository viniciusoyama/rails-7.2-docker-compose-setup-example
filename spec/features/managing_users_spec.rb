require 'rails_helper'

context 'Managing users' do 
  specify 'I can list users' do
    User.create(name: "Pedro")
    User.create(name: "Paula")
    
    visit users_path

    expect(page).to have_content("Pedro")
    expect(page).to have_content("Paula")
  end

  specify 'I add a user' do
    visit users_path

    click_link "New user"

    fill_in "Name", with: "New user"
    click_button "Create User"

    expect(page).to have_content("User was successfully created.")
    
    expect(User.last.name).to eq("New user")
  end
end