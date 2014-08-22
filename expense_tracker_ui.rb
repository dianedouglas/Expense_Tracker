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
  puts "\n#{@current_expense.description}"
  puts "Purchased on: #{@current_expense.date}"
  puts "$#{@current_expense.amount}"
end

def list_expenses
  if Expense.all.length == 0
    puts "You have not logged any expenses yet."
  else
    puts "\nHere are all your logged expenses.\n"
    Expense.all.each do |expense|
      @current_expense = expense
      print_expense
    end
  end
end

def list_categories
  if Category.all.length == 0
    puts "You have not created any categories yet."
  else
    puts "Here are all the categories you have for your expenses."
    Category.all.each do |category|
      puts "\n#{category.description}"
    end
  end
end

welcome
