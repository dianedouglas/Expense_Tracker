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


end