class Task
  attr_reader :id
  attr_accessor :done, :title, :description

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done]
  end

  def self.find(id)
    # return Task object
    result = DB.execute(('SELECT * FROM tasks WHERE id = ?'), id)
    return nil if result.empty?

    row = result[0]
    build_task(row)
  end

  def self.all
    query = 'SELECT * FROM tasks'
    rows = DB.execute(query)
    rows.map { |row| build_task(row) }
  end

  def save
    if @id.nil?
      query = <<-SQL
        INSERT INTO tasks (title, description, done)
        VALUES
        (?, ?, ?);
      SQL
      DB.execute(query, @title, @description, task_done)
      @id = DB.last_insert_row_id
    else
      query = <<-SQL
        UPDATE tasks
        SET title = ?, description = ?, done = ?
        WHERE id = ?
      SQL
      DB.execute(query, @title, @description, task_done, @id)
    end
  end

  def destroy
    query = 'DELETE FROM tasks WHERE id = ?'
    DB.execute(query, @id)
  end

  private

  def self.build_task(row)
    title = row['title']
    description = row['description']
    id = row['id']
    done = row['done'] == 1
    Task.new(id: id, title: title, description: description, done: done)
  end

  def task_done
    @done ? 1 : 0
  end
end
