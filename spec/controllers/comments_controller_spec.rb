require 'spec_helper'

describe CommentsController do
  describe 'create' do
    before do
      @user = User.create(email: 'user@example.com', password: '12345678')
      @post = Post.create(title: 'a', body: 'b', user: @user)
      expect(Comment.count).to eq 0
    end

    it 'creates comment' do
      post :create, { comment: { user_id: @user.id, post_id: @post.id, body: 'hello world' } }

      expect(Comment.count).to eq 1
      comment = Comment.first
      expect(comment.body).to eq 'hello world'
      expect(comment.post_id).to eq @post.id
      expect(comment.user_id).to eq @user.id
    end
  end
end
