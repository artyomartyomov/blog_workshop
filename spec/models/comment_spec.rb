require 'spec_helper'

describe Comment do
  it { should belong_to :post }
  it { should belong_to :user }

  it { should validate_presence_of :body }
  it { should validate_presence_of :user }

  it { should have_db_column(:body).of_type(:text) }
  it { should have_db_column(:post_id).of_type(:integer) }
  it { should have_db_column(:user_id).of_type(:integer) }
end
