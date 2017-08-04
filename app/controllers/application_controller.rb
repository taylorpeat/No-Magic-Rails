class ApplicationController < ActionController::Base
  def list_posts
    posts = connection.execute("SELECT * FROM posts")

    render 'application/list_posts', locals: { posts: posts }
  end

  def show_post
    post = Post.find(params['id'])

    render 'application/show_post', locals: { post: post }
  end

  def new_post
    render 'application/new_post'
  end

  def edit_post
    post = Post.find(params['id'])
    
    render 'application/edit_post', locals: { post: post }
  end

  def create_post
    post = Post.new('title' => params['title'],
                    'body' => params['body'],
                    'author' => params['author'],)
    post.save
    redirect_to '/list_posts'
  end

  def update_post
    post = Post.find(params['id'])
    
    post.update_attributes({
      params['title'],
      params['body'],
      params['author'],
      params['id']
    })
    post.save

    redirect_to "/show_post/#{params['id']}"
  end

  def delete_post
    delete_query = <<-SQL
      DELETE FROM posts
      WHERE id = ?
    SQL

    connection.execute(delete_query, params['id'])

    redirect_to '/list_posts'
  end

end
