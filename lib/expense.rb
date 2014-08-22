class Expense

	attr_accessor :description, :amount, :date, :id

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

end
