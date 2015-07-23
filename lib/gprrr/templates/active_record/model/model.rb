<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %><%= ', required: true' if attribute.required? %>
<% end -%>
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>

    # -----------------------------------------------------
    # Instance methods


    # -----------------------------------------------------
    # Class methods


    # -----------------------------------------------------
    # Private methods
    private

    # -----------------------------------------------------
    # rails_admin configuration
    rails_admin do
      list do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end
      show do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end
      edit do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end

      create do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end

      update do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end

      nested do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end

      modal do
      <%- attributes.each do |attribute| -%>
        field :<%= attribute.name %>
      <% end -%>
      end
    end
  end
<% end -%>