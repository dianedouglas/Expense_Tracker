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
	@test_expense = Expense.new({'description' => "Milk", 'amount' => 1.65, 'date' => 'Jan-08-1999'}) 
end