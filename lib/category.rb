class Category

  attr_reader :description, :id

  def initialize(attributes)
    @description = attributes['description']
    @id = attributes['id'].to_i
  end

end
