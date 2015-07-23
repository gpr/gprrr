require 'test_helper'

<% module_namespacing do -%>
describe <%= class_name %> do
  let(:<%= file_name %>) { build(:<%= file_name %>) }

  it 'must be valid' do
    value(<%= file_name %>).must_be :valid?
  end

  it 'must be saved' do
    value(<%= file_name %>.save).wont_be :nil?
  end
end
<% end -%>