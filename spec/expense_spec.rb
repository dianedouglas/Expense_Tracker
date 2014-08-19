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
end