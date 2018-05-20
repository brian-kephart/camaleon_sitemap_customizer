require 'test_helper'

class CamaleonSitemapCustomizer::Test < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, CamaleonSitemapCustomizer
  end

  test 'RuboCop finds no syntax errors' do
    assert_match /no offenses detected/, `rubocop --only Syntax`, 'RuboCop detected syntax errors. Run `rubocop --only Syntax` to find and fix these errors'
  end
end
