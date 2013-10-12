When /^I fill comment form$/ do
  fill_in 'comment_body', with: 'hello world'
end

And /^I submit comment$/ do
  click_button 'Create comment'
end

Then /^I see my comment$/ do
  page.should have_content('hello world')

  Comment.count.should == 1
  expect(Comment.count).to eq 1
  Comment.first.body.should == 'hello world'
end
