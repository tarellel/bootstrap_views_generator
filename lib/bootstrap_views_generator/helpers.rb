# frozen_string_literal: true

module BootstrapViewsGenerator
  module Helpers
    # Return a cleaned up version of the name of the application being generated
    # @return [String]
    def app_name
      # Avoid deprecation errors when pulling the application name when using Rails > 6.0
      @app_name ||= if Rails.version.to_f >= 6.0
                      Rails.app_class.module_parent_name.demodulize.titleize
                    else
                      Rails.application.class.parent.to_s.titleize
                    end
    end
  end
end