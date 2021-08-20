require 'sqlite3'
DB = SQLite3::Database.new('tasks.db')
DB.results_as_hash = true
require_relative 'task'

# TODO: CRUD some tasks

# 1. Implement the READ logic to find a given task (by its id)
task = Task.find(2)
puts "#{task.title} - #{task.description}"

# 2. Implement the CREATE logic in a save instance method
task = Task.new(title: 'Enjoy the weekend',
                description: 'Rest and relax')
task.save
puts "The new task's id is #{task.id}"

# 3. Implement the UPDATE logic in the same method
task = Task.find(2)
task.done = true
task.save

task = Task.find(2)
p task
puts "#{task.done == true ? '✅' : '❌'} #{task.title}"

# Implement the READ logic to retrieve all tasks (what type of method is it?)
tasks = Task.all
tasks.each do |task|
  puts "#{task.id}. #{task.title} - #{task.description}"
end


# Implement the destroy method

task = Task.find(2)
task.destroy

task = Task.find(2)
puts task.nil? # Should be true


# CREATE TABLE tasks (
#    id INTEGER PRIMARY KEY AUTOINCREMENT,
#    title TEXT,
#    description TEXT,
#    done INTEGER DEFAULT (0));
