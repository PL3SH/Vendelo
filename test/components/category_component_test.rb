# frozen_string_literal: true

require "test_helper"

class CategoryComponentTest < ViewComponent::TestCase
  test "should render an empty category" do
    assert_equal(
      %(\n<a class=\"category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-gray-300\" href=\"/\">Todos</a>\n),
      render_inline(CategoryComponent.new).to_html
    )
  end

  test "should render a category" do
    category = Category.last

    assert_equal(
      %(\n<a class=\"category text-gray-600 px-4 py-2 rounded-2xl drop-shadow-sm hover:bg-gray-300 bg-white\" href=\"/?category_id=#{category.id}\">#{category.name}</a>\n),
      render_inline(CategoryComponent.new(category: category)).to_html
    )
  end
end
