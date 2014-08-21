require 'PG'
require 'rspec'
require 'expense'
require 'pry'

DB = PG.connect({:dbname => 'expense_organizer'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM expenses *;")
  end
end

def setup_tests
  @test_expense = Expense.new({'description' => "Milk", 'amount' => 1.65, 'date' => '1999-01-08'}) 
  @test_expense_copy = Expense.new({'description' => "Milk", 'amount' => 1.65, 'date' => '1999-01-08'}) 
  #can input date as 01/08/1999 
end