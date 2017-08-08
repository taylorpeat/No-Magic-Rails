class Post < BaseModel
  attr_reader :id, :title, :body, :author, :created_at, :errors

  def initialize(attributes={})
    set_attributes(attributes)
    @errors = {}
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

  def comments
    comment_hashes = connection.execute 'SELECT * FROM comments WHERE comments.post_id = ?', id
    comment_hashes.map do |comment_hash|
      Comment.new(comment_hash)
    end
  end

  def create_comment(attributes)
    comment = build_comment(attributes)
    comment.save
  end

  def build_comment(attributes)
    Comment.new(attributes.merge!('post_id' => id))
  end

  def valid?
    @errors['title'] = "can't be blank" if title.blank?
    @errors['body'] = "can't be blank" if body.blank?
    @errors['author'] = "can't be blank" if author.blank? 
    @errors.empty?
  end
end