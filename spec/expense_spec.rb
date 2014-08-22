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

	describe ('#delete') do

		it 'will delete the expense from the database.' do
			@test_expense.save
			expect(Expense.all).to eq [@test_expense]
			@test_expense.delete
			expect(Expense.all).to eq []
		end
	end

	describe ('#update') do

		it 'will let you update the description of a purchase.' do
			@test_expense.save
			@test_expense.update_description('Organic Milk')
			expect(@test_expense.description).to eq 'Organic Milk'
			results = DB.exec("SELECT description FROM expenses WHERE id = #{@test_expense.id};")
			expect(results.first['description']).to eq 'Organic Milk'
		end

		it 'will let you update the amount of a purchase.' do
			@test_expense.save
			@test_expense.update_amount(7.99)
			expect(@test_expense.amount).to eq 7.99
			results = DB.exec("SELECT amount FROM expenses WHERE id = #{@test_expense.id};")
			expect(results.first['amount'].to_f).to eq 7.99
		end

		it 'will let you update the date of a purchase.' do
			@test_expense.save
			@test_expense.update_date('1989-01-08')
			expect(@test_expense.date).to eq '1989-01-08'
			results = DB.exec("SELECT date FROM expenses WHERE id = #{@test_expense.id};")
			expect(results.first['date']).to eq '1989-01-08'
		end
	end

	# describe ('#add_category, #categories') do

	# 	it 'will let you add a category to a purchase.' do
	# 		@test_expense.add_category(@test_category)
	# 		expect(@test_expense.categories).to eq [@test_category]
	# 	end
	# end
end
