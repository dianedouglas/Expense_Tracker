class Category

  attr_reader :description, :id

  def initialize(attributes)
    @description = attributes['description']
    @id = attributes['id'].to_i
  end

  def self.all
    categories = []
    results = DB.exec("SELECT * FROM categories;")
    results.each do |result|
      category = Category.new(result)
      categories << category
    end
    categories
  end

  def save
    results = DB.exec("INSERT INTO categories (description) VALUES ('#{@description}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(other_category)
    @description == other_category.description && @id == other_category.id
  end

  def delete
    DB.exec("DELETE FROM categories WHERE id = #{@id};")
  end

  def update_description(new_description)
    @description = new_description
    DB.exec("UPDATE categories SET description = '#{@description}' WHERE id = #{@id};")
  end

  def expenses
    expenses = []
    results = DB.exec("SELECT * FROM categories_expenses JOIN expenses ON (category_id = #{@id}) WHERE (expenses.id = expense_id);")
    results.each do |result|
      expense = Expense.new(result)
      expenses << expense
    end
    expenses    
  end
end
