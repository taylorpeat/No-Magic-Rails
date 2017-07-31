class ApplicationController < ActionController::Base
  def list_posts
    connection = SQLite3::Database.new 'db/development.sqlite3'
    connection.results_as_hash = true

    posts = connection.execute("SELECT * FROM posts")

    render 'application/list_posts', locals: { posts: posts }
  end
end
