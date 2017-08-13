class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      flash[:success] = "You have successfully created the comment."
      redirect_to post_path(@post)
    else
      flash[:error] = "Comment couldn't be created. Please check the errors."
      @post.reload.comments
      render 'posts/show'
    end
  end

  def destroy
    @post.comments.delete(params[:id])

    redirect_to post_path(@post)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def index
    @comments = Comment.all
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :author)
  end
end