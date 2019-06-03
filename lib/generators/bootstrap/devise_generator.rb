require 'rails/generators'

module Bootstrap
  module Generators
    class DeviseGenerator < ::Rails::Generators::Base
      hide!
      desc 'Overwrite default devise views'
      source_root ::File.expand_path('../templates/devise', __FILE__)

      class_option :template_engine, type: :string, default: 'erb', aliases: '-t', desc: 'Set template engine to generate the views with'
      class_option :metatags, type: :boolean, default: false, aliases: "-m", desc: 'If views will assign pages title using metatags gem'
      class_option :simpleform, type: :boolean, default: false, aliases: '-sf', desc: 'Enable SimpleForms for the form generating'

      def copy_confirmation
        template "#{options[:template_engine]}/confirmations/new.html.#{options[:template_engine]}.tt", "app/views/devise/confirmations/#{options[:template_engine]}"
      end

      def copy_mailers
        directory "#{options[:template_engine]}/mailer", 'app/views/devise/mailer'
      end

      def copy_passwords
        %i[edit new].map do |file|
          template "#{options[:template_engine]}/passwords/#{file}.html.#{options[:template_engine]}.tt", "app/views/devise/passwords/#{file}.html.#{options[:template_engine]}"
        end
      end

      def copy_registrations
        %i[edit new].map do |file|
          template "#{options[:template_engine]}/registrations/#{file}.html.#{options[:template_engine]}.tt", "app/views/devise/registrations/#{file}.html.#{options[:template_engine]}"
        end
      end

      def copy_sessions
        template "#{options[:template_engine]}/sessions/new.html.#{options[:template_engine]}.tt", "app/views/devise/sessions/new.html.#{options[:template_engine]}"
      end

      def copy_unlock
        template "#{options[:template_engine]}/unlocks/new.html.#{options[:template_engine]}.tt", "app/views/devise/unlocks/new.html.#{options[:template_engine]}"
      end

      # Copy shared files that have no meta-tags or template associated with them
      def copy_shared
        directory "#{options[:template_engine]}/shared", 'app/views/devise/shared'
      end

      private
      def file_template_location(file_location)
        # Will end up being something such as
        # => slim/unlocks/new.html.slim
        "#{options[:template_engine]}/#{file_location}.html.#{options[:template_engine]}"
      end
    end
  end
end
