require 'minitest_helper'

describe GemTemplate do
  it 'has a version number' do
    ::GemTemplate::VERSION.wont_be_nil
  end

  it 'does something useful' do
    GemTemplate.is_a?(Module).must_equal true
  end
end
