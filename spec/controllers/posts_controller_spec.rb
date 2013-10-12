require 'spec_helper'

describe PostsController do
  describe 'create' do
    before do
      @user = User.create(email: 'user@example.com', password: '12345678')
      expect(Post.all.count).to eq 0
    end

    it 'creates post' do
      post :create, { post: { user_id: @user.id, title: 'First post', body: 'hello world' } }

      expect(Post.all.count).to eq 1
      post = Post.first
      expect(post.title).to eq 'First post'
      expect(post.body).to eq 'hello world'
      expect(post.user_id).to eq @user.id
    end
  end

  describe 'update' do
    before do
      @user = User.create(email: 'user@example.com', password: '12345678')
      @post = Post.create(title: '1', body: '2', user: @user)
    end

    it 'updates post' do
      put :update, id: @post.id, post: { title: '3', body: '4' }

      @post.reload
      expect(@post.title).to eq '3'
      expect(@post.body).to eq '4'
    end
  end
end
