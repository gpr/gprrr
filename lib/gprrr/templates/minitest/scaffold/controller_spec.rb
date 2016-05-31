require 'test_helper'

<% module_namespacing do -%>
describe <%= controller_class_name %>Controller do
  let(:<%= singular_table_name %>) { create(:<%= singular_table_name %>) }
  let(:new_<%= singular_table_name %>) { build(:<%= singular_table_name %>) }

<% if namespaced? -%>
  before do
    @routes = Engine.routes
    @<%= singular_table_name %> = create(:<%= singular_table_name %>)
  end
<% end %>

  it 'gets index' do
    get :index
    value(response).must_be :success?
    value(assigns(:<%= table_name %>)).wont_be :nil?
  end

  it 'gets new' do
    get :new
    value(response).must_be :success?
  end

  it 'creates <%= singular_table_name %>' do
    expect {
      post :create, <%= "#{singular_table_name}: " + "{" + attributes.map { |attribute| "#{attribute.name}: new_#{singular_table_name}.#{attribute.name}" }.join(', ') + "}" %>
    }.must_change '<%= class_name %>.count'

    must_redirect_to <%= singular_table_name %>_path(assigns(:<%= singular_table_name %>))
  end

  it 'shows <%= singular_table_name %>' do
    get :show, id: <%= singular_table_name %>
    value(response).must_be :success?
  end

  it 'gets edit' do
    get :edit, id: <%= singular_table_name %>
    value(response).must_be :success?
  end

  it 'updates <%= singular_table_name %>' do
    put :update, id: <%= singular_table_name %>, <%= "#{singular_table_name}: " + "{" + attributes.map { |attribute| "#{attribute.name}: new_#{singular_table_name}.#{attribute.name}" }.join(', ') + "}" %>
    must_redirect_to <%= singular_table_name %>_path(assigns(:<%= singular_table_name %>))
  end

  it 'destroys <%= singular_table_name %>' do
    id = <%= singular_table_name %>.id
    expect {
      delete :destroy, id: id
    }.must_change '<%= class_name %>.count', -1

    must_redirect_to <%= index_helper %>_path
  end
end
<% end -%>
