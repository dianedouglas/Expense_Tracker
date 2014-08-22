require 'PG'
require 'rspec'
require 'expense'
require 'category'
require 'pry'

DB = PG.connect({:dbname => 'expense_tracker'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
    DB.exec("DELETE FROM categories *;")
  end
end

def setup_tests
  @test_expense = Expense.new({'description' => "Milk", 'amount' => 1.65, 'date' => '1999-01-08'})
  @test_expense_copy = Expense.new({'description' => "Milk", 'amount' => 1.65, 'date' => '1999-01-08'})
  @test_category = Category.new({'description' => "Groceries"})
  #can input date as 01/08/1999
end
