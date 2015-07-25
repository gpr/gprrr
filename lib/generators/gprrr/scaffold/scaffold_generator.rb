require 'rails/generators/erb/scaffold/scaffold_generator'

module Gprrr # :nodoc:
  module Generators # :nodoc:
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path('../templates', __FILE__)

      hook_for :form_builder, as: :scaffold

      protected

      def available_views
        %w(index new show update _form _record _table)
      end
    end
  end
end
