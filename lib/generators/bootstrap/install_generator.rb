require 'rails/generators'
require_relative 'devise_generator'

module Bootstrap
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Overwrite default view scaffolding'
      source_root ::File.expand_path('../templates', __FILE__)
      class_option :template_engine,    type: :string, default: 'erb', aliases: '-t', enum: %w[erb slim haml],
                                        desc: 'The template_engine to use for generating the applications views (Erb, Slim, HAML)'

      # Boolean flags that can be flagged by adding to the generator call ie: --pagination or --metag_tags
      class_option :devise,             type: :boolean, default: false,
                                        desc: 'If views for devise will be required by the generator'

      class_option :layout,             type: :boolean, default: false, aliases: '-l',
                                        desc: 'Over-write your application layout file with a bootstrap based layout'

      class_option :metatags,           type: :boolean, default: false, aliases: '-m',
                                        desc: 'If views will assign pages title using metatags gem'

      class_option :pagination,         type: :boolean, default: false, aliases: '-p',
                                        desc: 'Toggle if pagination will be used with the index view/controller (based off of Pagy)'

      class_option :simpleform,         type: :boolean, default: false, aliases: '-sf',
                                        desc: 'Enable SimpleForms for the form generating'

      class_option :skip_javascript,    type: :boolean, default: false,
                                        desc: 'Skip adding javascript_include_tag or javascript_pack_tag to the layouts'

      class_option :skip_turbolinks,    type: :boolean, default: false,
                                        desc: 'Skip associating assets and views with turbolinks'

      def copy_scaffold_views
        %w[edit index show new].each do |file|
          template "scaffolds/#{options[:template_engine]}/#{file}.html.#{options[:template_engine]}", "lib/templates/#{options[:template_engine]}/scaffold/#{file}.html.#{options[:template_engine]}", force: true
        end
        copy_file "scaffolds/#{options[:template_engine]}/_form.html.#{options[:template_engine]}", "lib/templates/#{options[:template_engine]}/scaffold/_form.html.#{options[:template_engine]}", force: true
      end

      def create_layout
        template("layouts/application.html.#{options[:template_engine]}.tt", "app/views/layouts/application.html.#{options[:template_engine]}", force: true) if options[:layout]
      end

      def copy_shared_pagination
        copy_file("shared/_pagination.html.#{options[:template_engine]}", "app/views/shared/_pagination.html.#{options[:template_engine]}", force: true) if options[:pagination]
      end

      def copy_simpleforms
        copy_file("simple_form/_form.html.#{options[:template_engine]}", "lib/templates/#{options[:template_engine]}/scaffold/_form.html.#{options[:template_engine]}", force: true) if options[:simpleform]
      end

      # Inject Bootstrap helpers into teh application_helper file
      def inject_helpers
        pagy_helper = (options[:pagination] ? 'include Pagy::Frontend' : '')
        helper_str = <<~HELPER
        #{pagy_helper}

        # https://gist.github.com/fjahr/b3828b9f4e333e74ba1894687d65e055
        def bootstrap_class_for(flash_type)
          { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }.stringify_keys[flash_type.to_s] || flash_type.to_s
        end

        def flash_messages(_opts = [])
          return '' unless flash.any?

          flash.each do |msg_type, message|
            next unless !message.nil? && message.to_s.length.positive?

            concat(content_tag(:div, message, class: "alert \#{bootstrap_class_for(msg_type)}", role: 'alert') do
              concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
              concat message
            end)
          end
          nil
        end

        # for outputting an objects error messages
        def errors_for(object)
          return '' unless object.errors.any?

          content_tag(:div, class: 'card border-danger') do
            concat(content_tag(:div, class: 'card-header bg-danger text-white') do
              concat "\#{pluralize(object.errors.count, 'error')} prohibited this \#{object.class.name.downcase} from being saved:"
            end)
            concat(content_tag(:ul, class: 'mb-0 list-group list-group-flush') do
              object.errors.full_messages.each do |msg|
                concat content_tag(:li, msg, class: 'list-group-item')
              end
            end)
          end
        end
      HELPER
        inject_into_file 'app/helpers/application_helper.rb', optimize_indentation(helper_str,2), after: "module ApplicationHelper\n"
      end

      def invoke_devise_generator
        # Generate bootstrap based devise views if devise is being used
        invoke('bootstrap:devise') if options[:devise]
      end
    end
  end
end
