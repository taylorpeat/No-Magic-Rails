class CommentsController < ApplicationController
  def create
    @post = Post.find(params['post_id'])
    @comment = @post.build_comment('body' => params['body'], 'author' => params['author'])

    if @comment.save
      redirect_to post_path(@post.id)
    else
      render 'posts/show'
    end
  end

  def destroy
    comment = Comment.find(params['comment_id'])
    comment.destroy

    redirect_to post_path(comment.post_id)
  end

  def index
    @comments = Comment.all
  end
end