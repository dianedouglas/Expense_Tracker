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

end
