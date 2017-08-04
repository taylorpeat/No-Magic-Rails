class ApplicationController < ActionController::Base
  def list_posts
    posts = Post.all

    render 'application/list_posts', locals: { posts: posts }
  end

  def show_post
    post = Post.find(params['id'])

    render 'application/show_post', locals: { post: post }
  end

  def new_post
    post = Post.new

    render 'application/new_post', locals: { post: post }
  end

  def edit_post
    post = Post.find(params['id'])

    render 'application/edit_post', locals: { post: post }
  end

  def create_post
    post = Post.new('title' => params['title'],
                    'body' => params['body'],
                    'author' => params['author'],)
    if post.save
      redirect_to '/list_posts'
    else
      render '/new_post', locals: { post: post }
    end
  end

  def update_post
    post = Post.find(params['id'])
    
    post.set_attributes({
      'title' => params['title'],
      'body' => params['body'],
      'author' => params['author'],
      'id' => params['id']
    })
    if post.save
      redirect_to "/show_post/#{params['id']}"
    else
      render "application/edit_post", locals: { post: post }
    end
  end

  def delete_post
    post = Post.find(params['id'])
    post.delete

    redirect_to '/list_posts'
  end

end
