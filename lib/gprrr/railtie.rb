require 'gprrr/helpers/record_links_helpers'

module Gprrr
  class Railtie < Rails::Railtie
    config.app_generators do |g|
      g.templates.unshift File::expand_path('../templates', __FILE__)
    end

    initializer 'gprrr.record_links_helper' do
      ActionView::Base.send :include, RecordLinksHelper
    end
  end
end