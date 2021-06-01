require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date       # store the  instance variable
    @completed = completed
  end

  def overdue?
    @due_date < Date.today       #check the due_date lessthen current date
  end

  def due_today?
    @due_date == Date.today    #check the due_date equal to current date
  end

  def due_later?
    @due_date > Date.today    #check the due_date greater then to current date
  end

  def to_displayable_string
    diplay_value = ""
    if @due_date == Date.today and @completed == false #due_date equal to current date and completed false and print the text
      diplay_value += "[ ]#{@text}"                         #stroe the display_value
    elsif @due_date == Date.today and @completed == true #due_date equal to current date and completed true and print the text
      diplay_value += "[X]#{@text}"                           #stroe the display_value
    elsif @due_date == Date.today and @completed == false #due_date equal to current date and completed false and print the text
      diplay_value += "[ ]#{@text} #{@due_date}"              #stroe the display_value
    else
      diplay_value += "[ ] #{@text} #{@due_date}"
    end
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })    #create  a object   todolist and Fliter  todo and iterator the todo
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new((@todos.filter { |todo| todo.due_later? }))
  end

  def add(test)
    @todos.push(test)           #  This  Function  push the text From @todos
  end

  def to_displayable_list
    arr = []
    @todos.each do |i| # iterator the @todos
      arr << i.to_displayable_string.to_s        #   todisplay_string  method add to array
    end
    return arr.join("\n")  #return array
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
