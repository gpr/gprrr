<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"
<% end -%>
<% module_namespacing do -%>
class <%= class_name %>Controller < ApplicationController
<% actions.each do |action| -%>
  def <%= action %>
    authorize class_name, :<%= action %>?
  end
<%= "\n" unless action == actions.last -%>
<% end -%>
end
<% end -%>