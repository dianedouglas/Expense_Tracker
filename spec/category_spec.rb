require 'helper_spec'

describe Category do

  before do
    setup_tests
  end

  describe ('#initialize') do

    it 'will create an category object.' do
      expect(@test_category).to be_an_instance_of Category
    end
  end

  describe ('#attributes') do

    it 'will return the value of each attribute of category.' do
      expect(@test_category.description).to eq 'Groceries'
    end
  end

  describe ('.all') do

    it 'will return all existing categories from the database. It should start empty.' do
      expect(Category.all).to eq []
    end
  end

  describe ('#save, #eq, .all') do

    it 'will save the category to the database.' do
      @test_category.save
      expect(Category.all).to eq [@test_category]
    end
  end

  describe ('#delete') do

    it 'will delete the category from the database.' do
      @test_category.save
      expect(Category.all).to eq [@test_category]
      @test_category.delete
      expect(Category.all).to eq []
    end
  end

  describe ('#update') do

    it 'will let you update the description of a category.' do
      @test_category.save
      expect(@test_category.description).to eq 'Groceries'
      results = DB.exec("SELECT description FROM categories WHERE id = #{@test_category.id};")
      expect(results.first['description']).to eq 'Groceries'

      @test_category.update_description('Drinks')
      expect(@test_category.description).to eq 'Drinks'
      results = DB.exec("SELECT description FROM categories WHERE id = #{@test_category.id};")
      expect(results.first['description']).to eq 'Drinks'
    end
  end

end
