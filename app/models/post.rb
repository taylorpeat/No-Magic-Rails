class Post
  attr_reader :id, :title, :body, :author, :created_at

  def initialize(attributes={})
    set_attributes(attributes)
  end

  def save
    if @id.nil?
      insert
    else
      update
    end
  end

  def insert
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
      params['title'],
      params['body'],
      params['author'],
      Date.current.to_s
  end

  def update
    update_query = <<-SQL
      UPDATE posts
      SET title  = ?,
          body   = ?,
          author = ?
      WHERE id   = ?
    SQL

    connection.execute update_query,
      @title,
      @body,
      @author,
      @id
  end

  def set_attributes(attributes={})
    @id = attributes['id'] if @id.nil?
    @title = attributes['title'] || @title
    @body = attributes['body'] || @body
    @author = attributes['author'] || @author
    @created_at ||= attributes['created_at']
  end

  def self.find(id)
    post_hash = connection.execute("SELECT * FROM posts WHERE id = ? LIMIT 1", id).first
    Post.new(post_hash)
  end

  private

  def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end
end