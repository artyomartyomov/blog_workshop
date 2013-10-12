When /^I log in$/ do
  @user = User.create(email: 'user@example.com', password: '12345678')

  visit '/users/sign_in'

  fill_in 'user_email', with: @user.email
  fill_in 'user_password', with: '12345678'

  click_button 'Sign in'
end

Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end
