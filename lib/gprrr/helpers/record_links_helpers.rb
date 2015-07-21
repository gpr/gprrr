module Gprrr
  module RecordLinksHelper

    def link_index(model, icon=:database, text=nil, app=main_app)
      if policy(model).index?
        link_to app.polymorphic_path(model) do
          fa_icon icon, text: text
        end
      end
    end

    def link_edit(model, text=nil, app=main_app)
      if policy(model).update?
        link_to app.polymorphic_path(model, action: :edit) do
          fa_icon 'edit', text: text
        end
      end
    end

    def link_destroy(model, text=nil, app=main_app)
      if policy(model).destroy?
        link_to app.polymorphic_path(model), method: :delete,
                data: { confirm: t(:delete_confirmation, model: model.class.name, id: model.id) } do
          fa_icon 'times', text: text
        end
      end
    end

    def link_show(model, text=nil, app=main_app)
      if policy(model).show?
        link_to  app.polymorphic_path(model) do
          fa_icon 'eye', text: text
        end
      else
        text
      end
    end

    def link_create(model, text=nil, app=main_app)
      if policy(model).create?
        link_to app.polymorphic_path(model, action: :new) do
          fa_icon 'plus', text: text
        end
      end
    end

  end
end