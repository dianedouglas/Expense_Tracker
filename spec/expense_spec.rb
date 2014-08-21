require 'helper_spec'

describe 'Expense' do

	before do
		setup_tests
	end

	describe ('#initialize') do
		
		it 'will create an expense object.' do
			expect(@test_expense).to be_an_instance_of Expense
		end
	end

	describe ('#attributes') do 

		it 'will return the value of each attribute of expense.' do 
			expect(@test_expense.description).to eq 'Milk'
			expect(@test_expense.amount).to eq 1.65
			expect(@test_expense.date).to eq '1999-01-08'
		end
	end

	describe ('.all') do

		it 'will return all existing expenses from the database. It should start empty.' do
			expect(Expense.all).to eq []
		end
	end

	describe ('#save, #eq, .all') do

		it 'will save the expense to the database.' do
			@test_expense.save
			expect(Expense.all).to eq [@test_expense]
		end
	end
end