require 'test_helper'

<% module_namespacing do -%>
describe <%= class_name %> do
  let(:<%= file_name %>) { build(:<%= file_name %>) }

  it 'must be valid' do
    <%= file_name %>.valid?
    value(<%= file_name %>.errors.messages).must_be_empty
  end

  it 'must be saved' do
    value(<%= file_name %>.save).wont_be :nil?
  end
end
<% end -%>