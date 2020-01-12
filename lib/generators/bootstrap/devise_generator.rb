# frozen_string_literal: true

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
        template "#{file_template_location('confirmations/new')}.tt", "app/views/devise/confirmations/new.html.#{options[:template_engine]}"
      end

      def copy_mailers
        directory "#{options[:template_engine]}/mailer", 'app/views/devise/mailer'
      end

      def copy_passwords
        %i[edit new].map do |file|
          template "#{file_template_location("passwords/#{file}")}.tt", "app/views/devise/passwords/#{file}.html.#{options[:template_engine]}"
        end
      end

      def copy_registrations
        %i[edit new].map do |file|
          template "#{file_template_location("registrations/#{file}")}.tt", "app/views/devise/registrations/#{file}.html.#{options[:template_engine]}"
        end
      end

      def copy_sessions
        template "#{file_template_location('sessions/new')}.tt", "app/views/devise/sessions/new.html.#{options[:template_engine]}"
      end

      def copy_unlock
        template "#{options[:template_engine]}/unlocks/new.html.#{options[:template_engine]}.tt", "app/views/devise/unlocks/new.html.#{options[:template_engine]}"
      end

      # Copy shared files that have no meta-tags or template associated with them
      def copy_shared
        directory "#{options[:template_engine]}/shared", 'app/views/devise/shared'
      end

      private
      def file_template_location(file_location = '')
        return '' if file_location.blank?
        # Dpending if simpleform is to be used, it will return a path similar to one of the following:
        # => slim/unlocks/new.html.slim || simple_form/slim/unlocks/new.html.slim
        "#{simple_path}#{options[:template_engine]}/#{file_location}.html.#{options[:template_engine]}"
      end

      # If simpleform is going ot be used with the forms return a simple_form path
      def simple_path
        options[:simpleform] ? 'simple_form/' : ''
      end
    end
  end
end
