class Expense

	attr_accessor :description, :amount, :date

	def initialize(attributes)
		@description = attributes['description']
		@amount = attributes['amount'].to_f
		@date = attributes['date']
	end

end