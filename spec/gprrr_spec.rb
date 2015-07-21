require 'minitest_helper'

describe Gprrr do
  it 'has a version number' do
    ::Gprrr::VERSION.wont_be_nil
  end

  it 'does something useful' do
    Gprrr.is_a?(Module).must_equal true
  end
end
