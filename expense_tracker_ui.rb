require './lib/expense'
require './lib/category'
require 'pry'
require 'PG'

DB = PG.connect({:dbname => 'expense_tracker'})
@current_expense = nil
@current_category = nil

def welcome
  puts "Alan please add content.\n\n"
  main_menu
end

def main_menu
  choice = nil
  until choice == 'X'

    puts "\n\nPlease choose an option, deary. "
    puts "Press [AE] to add an expense."
    puts "Press [AC] to add a category."
    puts "Press [EE] to edit an expense."
    puts "Press [EC] to edit a category."
    puts "Press [LE] to list all expenses."
    puts "Press [LC] to list all categories."
    puts "Press [CE] to place an expense into a category."
    puts "Press [LEC] to list all expenses from one category."
    puts "Press [LCE] to list all categories of one expense."
    puts "Press [X] to exit."

    choice = gets.chomp.upcase
    case choice

    when 'AE'
      add_expense
    when 'AC'
      add_category
    when 'EE'
      edit_expense
    when 'EC'
      edit_category
    when 'LE'
      list_expenses
    when 'LC'
      list_categories
    when 'LEC'
      list_expenses_in_a_category
    when 'LCE'
      list_categories_in_a_expense
    when 'X'
      exit
    else
      puts "That's not an option, silly!\n\n"
    end
  end
end

def add_expense
  puts "What did you buy?"
  description = gets.chomp
  puts "How much was it?"
  price = gets.chomp.to_f
  puts "What day was it? \nEnter date with mm/dd/yyyy. \nFor example: '01/08/1999'"
  date = gets.chomp
  @current_expense = Expense.new({'description' => description, 'amount' => price, 'date' => date})
  @current_expense.save
  puts "You have just saved: "
  print_expense
end

def add_category
  puts "What are you going to call this category? Enter a description."
  description = gets.chomp
  @current_category = Category.new({'description' => description})
  @current_category.save
  list_categories
end

def print_expense
  puts "#{@current_expense.description}"
  puts "Purchased on: #{@current_expense.date}"
  puts "$#{@current_expense.amount}"
end

def list_expenses
  if Expense.all.length == 0
    puts "You have not logged any expenses yet."
    @current_expense = nil
  else
    puts "\nHere are all your logged expenses.\n"
    Expense.all.each_with_index do |expense, i|
      @current_expense = expense
      puts "Expense #" + i.to_s
      print_expense
    end
  end
end

def list_categories
  if Category.all.length == 0
    puts "You have not created any categories yet."
    @current_category = nil
  else
    puts "Here are all the categories you have for your expenses."
    Category.all.each do |category|
      puts "\n#{category.description}"
    end
  end
end

def select_expense
  list_expenses
  if @current_expense != nil
    puts "Choose an expense by typing its number."
    expense = gets.chomp.to_i
    if

  else
    puts "You need to add some expenses before you can edit them."
    main_menu
  end
end

def select_category

end

def edit_expense
  select_expense
  choice = nil
  until choice == 'M'
    puts "Press [N] to edit the name of the expense."
    puts "Press [P] to edit the price of the expense."
    puts "Press [D] to edit the date of purchase."
    puts "Press [R] to remove the purchase."
    puts "Press [M] to return to the main menu."
    choice = gets.chomp.upcase
    case choice
    when 'N'
      puts "Enter new name:"
      name = gets.chomp
      @current_expense.update_description(name)
      puts "OK, here ya go: "
      print_expense
    when 'P'
      puts "Enter new price:"
      price = gets.chomp
      @current_expense.update_amount(price)
      puts "OK, here ya go: "
      print_expense
    when 'D'
      puts "Enter new date:"
      date = gets.chomp
      @current_expense.update_date(date)
      puts "OK, here ya go: "
      print_expense
    when 'R'
      puts "It's gone! Here are your other expenses."
      @current_expense.delete
      list_expenses
    when 'M'
      main_menu
    else
      puts "That's not an option, silly!\n\n"
    end
  end

end

def edit_category
  select_category
  choice = nil
  until choice == 'M'
    puts "Press [N] to edit the name of the category."
    puts "Press [R] to remove the category."
    puts "Press [M] to return to the main menu."
    choice = gets.chomp.upcase
    case choice
    when 'N'
      puts "Enter new name:"
      name = gets.chomp
      @current_expense.update_description(name)
      puts "OK, here ya go: "
      puts "#{@current_category.description}"
    when 'R'
      puts "It's gone! Here are your other expenses."
      @current_category.delete
      list_categories
    when 'M'
      main_menu
    else
      puts "That's not an option, silly!\n\n"
    end
  end
end

welcome
#dollar sign, date formatting
