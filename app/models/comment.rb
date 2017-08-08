class Comment
  attr_reader :id, :body, :author, :post_id, :created_at, :errors

  def initialize(attributes={})
    @id = attributes['id'] if new_record?
    @body = attributes['body']
    @author = attributes['author']
    @post_id = attributes['post_id']
    @created_at ||= attributes['created_at']
    @errors = {}
  end

  def valid?
    @errors['body'] = "can't be blank" if body.blank?
    @errors['author'] = "can't be blank" if author.blank? 
    @errors.empty?
  end

  def new_record?
    @id.nil?
  end

  def save
    return false unless valid?

    if new_record?
      insert
    else
      # update # ...not yet defined
    end

    true
  end

  def insert
    insert_comment_query = <<-SQL
      INSERT INTO comments (body, author, post_id, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_comment_query,
      @body,
      @author,
      @post_id,
      Date.current.to_s
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