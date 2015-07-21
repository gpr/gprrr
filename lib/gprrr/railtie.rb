require 'gprrr/helpers/record_links_helpers'

module Gprrr
  class Railtie < Rails::Railtie
    initializer 'gprrr.record_links_helper' do
      ActionView::Base.send :include, RecordLinksHelper
    end
  end
end