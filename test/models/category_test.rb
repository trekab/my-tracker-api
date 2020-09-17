require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'category should have a unique name' do
    other_category = categories(:one)
    category = Category.new(name: other_category.name)
    assert_not category.valid?
  end
end
