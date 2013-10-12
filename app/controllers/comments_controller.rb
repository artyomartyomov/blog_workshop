class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(@comment.post)
    else
      @post = @comment.post
      render 'posts/show', id: @post.id
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
