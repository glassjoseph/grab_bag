feature 'Visitor logs in' do
  context 'Visitor already has an account' do
    User.create!(fbid: 1234,
                 username: 'dummyaccount',
                 email: 'samlandfried@gmail.com',
                 phone_number: '555-555-5555',
                 token: "whatever")

    stub_omniauth

    visit '/'
    click_on 'Login'

    expect(current_path).to eq("/#{user.username}/home")
    expect(page).to have_content "dummyaccount"
    expect(page).to have_link "Logout"
    expect(page).to_not have_link "Login"
# When I visit '/' path
# And I click on the login button
# I expect the current path to '/:username/home'
# I expect to see a flash message "Successfully logged in"
  end
end
