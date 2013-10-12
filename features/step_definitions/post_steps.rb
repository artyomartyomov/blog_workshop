Given /^I am on posts page$/ do
  visit '/posts'
end

When /^I follow "create new post"$/ do
  click_link 'create new post'
end

When /^I fill post form$/ do
  fill_in 'post_title', with: 'First post'
  fill_in 'post_body', with: 'hello world'
end

And /^I submit posts form$/ do
  click_button 'Create post'
end

Then /^I should be on posts page$/ do
  current_path = URI.parse(current_url).path
  current_path.should == '/posts'
end

And /^I should see my new post$/ do
  page.should have_content('First post')
  page.should have_content('hello world')

  Post.all.count.should == 1
end

Given /^I am on post page$/ do
  post = Post.create!(title: 'a', body: 'b', user_id: User.last.id)

  visit post_path(post)
end
