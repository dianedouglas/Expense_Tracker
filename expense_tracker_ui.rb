require './lib/expense'
require 'pry'
require 'PG'

@current_expense = nil

def welcome
  puts "Alan please add content.\n\n"
  main_menu
end

def main_menu
  choice = nil
  until choice == 'X'

    puts "\n\nPlease choose an option, deary. "
    puts "Press [A] to add an expense."
    puts "Press [X] to exit."
    
    choice = gets.chomp
    case choice

    when 'A'
      add_expense
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
  binding.pry
  puts "You have just saved: "
  print_expense
end

def print_expense
  puts "\n#{@current_expense.description}"
  puts "Purchased on: #{@current_expense.date}"
  puts "$#{@current_expense.amount}"
end

welcome