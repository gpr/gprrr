<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  # GET <%= route_url %>
  def index
    authorize <%= namespace %>::<%= class_name %>, :index?
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>.order(params[:order]).page(params[:page])
    respond_with(@<%= plural_table_name %>)
  end

  # GET <%= route_url %>/1
  def show
    authorize @<%= singular_table_name %>, :show?
    respond_with(@<%= singular_table_name %>)
  end

  # GET <%= route_url %>/new
  def new
    authorize <%= namespace %>::<%= class_name %>, :create?
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
    respond_with(@<%= singular_table_name %>)
  end

  # GET <%= route_url %>/1/edit
  def edit
    authorize @<%= singular_table_name %>, :edit?
  end

  # POST <%= route_url %>
  def create
    authorize <%= namespace %>::<%= class_name %>, :create?
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
    @<%= orm_instance.save %>
    respond_with(@<%= singular_table_name %>)
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    authorize @<%= singular_table_name %>, :update?
    respond_with(@<%= singular_table_name %>) do |format|
      if @<%= orm_instance.update("#{singular_table_name}_params") %>
        flash[:notice] = "<%= class_name %> ##{@<%= singular_table_name%>.id} succesfully updated."
        format.json { respond_with_bip(@<%= singular_table_name %>) }
      else
        format.json do
          flash[:error] = []
          @<%= singular_table_name%>.errors.messages.each do |attr, mesgs|
            flash[:error] << "'#{attr.to_s.humanize}' #{mesgs.to_sentence.humanize(capitalize: false)}"
          end
          respond_with_bip(@<%= singular_table_name %>)
        end
      end
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    authorize @<%= singular_table_name %>, :destroy?
    @<%= orm_instance.destroy %>
    respond_with(@<%= singular_table_name %>)
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  # Only allow a trusted parameter "white list" through.
  def <%= "#{singular_table_name}_params" %>
  <%- if attributes_names.empty? -%>
    params[:<%= singular_table_name %>]
  <%- else -%>
    params.require(:<%= singular_table_name %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
  <%- end -%>
  end
end
<% end -%>