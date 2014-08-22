class Expense

	attr_reader :description, :amount, :date, :id

	def initialize(attributes)
		@description = attributes['description']
		@amount = attributes['amount'].to_f
		@date = attributes['date']
		@id = attributes['id'].to_i
	end

	def self.all
		expenses = []
		results = DB.exec("SELECT * FROM expenses;")
		results.each do |result|
			expense = Expense.new(result)
			expenses << expense
		end
		expenses
	end

	def save
		results = DB.exec("INSERT INTO expenses (description, amount, date) VALUES ('#{@description}', '#{@amount}', '#{@date}') RETURNING id;")
		@id = results.first['id'].to_i
	end

	def ==(other_expense)
		@description == other_expense.description && @amount == other_expense.amount && @date == other_expense.date && @id == other_expense.id
	end

	def delete
		DB.exec("DELETE FROM expenses WHERE id = #{@id};")
	end

	def update_description(new_description)
		@description = new_description
		DB.exec("UPDATE expenses SET description = '#{@description}' WHERE id = #{@id};")
	end

	def update_amount(new_amount)
		@amount = new_amount
		DB.exec("UPDATE expenses SET amount = #{@amount} WHERE id = #{@id};")
	end

	def update_date(new_date)
		@date = new_date
		DB.exec("UPDATE expenses SET date = '#{@date}' WHERE id = #{@id};")
	end

  def add_category(category)
  	DB.exec("INSERT INTO categories_expenses (expense_id, category_id) VALUES (#{@id}, #{category.id});")
  end

  def categories
  	categories = []
  	results = DB.exec("SELECT * FROM categories_expenses WHERE expense_id = #{@id};")
  	results.each do |result|
  		category_id = result['category_id']
  		category_results = DB.exec("SELECT * FROM categories WHERE id = #{category_id};")
  		category_results.each do |category|
	  	  category = Category.new(category)
	  	  categories << category
	  	end
  	end
  	categories
  end
end
