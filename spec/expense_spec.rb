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
			expect(@test_expense.date).to eq '01/08/1999'
		end
	end
end