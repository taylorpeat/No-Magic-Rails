class PostsController < ApplicationController
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params['id'])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params['id'])
  end

  def create
    @post = Post.new('title' => params['title'],
                    'body' => params['body'],
                    'author' => params['author'],)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def update
    binding.pry
    @post = Post.find(params['id'])
    
    @post.set_attributes({
      'title' => params['title'],
      'body' => params['body'],
      'author' => params['author'],
      'id' => params['id']
    })
    if @post.save
      redirect_to post_path(@post.id)
    else
      render 'edit'
    end
  end

  def destroy
    post = Post.find(params['id'])
    post.destroy
  end
end