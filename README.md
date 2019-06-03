# BootstrapViewsGenerator

![](https://ruby-gem-downloads-badge.herokuapp.com/bootstrap_views_generator?type=total)  [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT) [![Gem](https://img.shields.io/gem/v/bootstrap_views_generator.svg?style=flat)](http://rubygems.org/gems/bootstrap_views_generator "View this project in Rubygems")

This gem is used for generating Bootstrap based scaffold views for your Rails application. They can be Erb, Slim, or HAML. You can include pagination (using Pagy), simple_form (for the form components), and if you'd like you can utilize the meta-tags gems to all dynamic page titles when switching between your view components.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bootstrap_views_generator', group: :development

# Now make sure you have the bootstrap gem installed in your Gemfile
gem 'bootstrap', '~> 4.3'

# And ensure you have bootstrap included in your application.scss
@import 'bootstrap';
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bootstrap_views_generator

## Usage

```shell
Usage:
  rails g bootstrap:install [options]

Options:
Options:
-t, [--template-engine=TEMPLATE_ENGINE]     # Indicates when to generate using a designated template engine (erb, slim, haml)
                                            # Default: erb
--simpleform                                # Indicates if simple_form is to be used to generate the forms
                                            # Default: false
--pagination                                # Specify if you want to add pagination to the index pages
                                            # Defaults: false (requires Pagy to use pagination)
--metatags                                  # If you want the pages titles to use the metatags gem function for the page title
                                            # Default: false
--layout                                    # Over-write your application layout file with a bootstrap based layout
                                            # Default: false
--devise                                    # If you want to generate bootstrap based devise views
                                            # Default: false
```

## Options

##### Template Engines

Supported Template Engines

* ERB
* HAML
* Slim

**HAML**

Make sure you have haml added to your your Gemfile
```ruby
gem 'haml-rails'

# generate haml views
rails g bootstrap:install --template_engine=haml
```

**Slim**
Make sure you have Slim added to your Gemfile
```ruby
gem 'slim-rails'

# generate Slim views
rails g bootstrap:install --template_engine=slim
```

#### Pagination

Ensure you have [Pagy](https://github.com/ddnexus/pagy) gem installed
```ruby
# Gemfile
gem 'pagy'

# Make sure you have the bootstrap pagy helper included
# config/initializers/pagy.rb
require 'pagy/extras/bootstrap'
```


#### Meta-Tags
Ensure you have the [meta-tags](https://github.com/kpumuk/meta-tags) gem installed
```ruby
gem 'meta-tags'
```

### Examples

Generate bootstrap views with pagination enabled
```shell
rails g bootstrap:install --pagination
```

Generate bootstrap views with slim and using simple_form
```shell
rails g bootstrap:install --template_engine=slim --simpleform
```

### Extras

* If you like to use the [meta-tags](https://github.com/kpumuk/meta-tags) gem to add page titles based on the views.
* Pagination defaults to using [Pagy](https://github.com/ddnexus/pagy) on the index pages.
* With [simple_form](https://github.com/plataformatec/simple_form) it is assumed your have already run the simple_form generator for displaying bootstrap based components.
  ```shell
  rails generate simple_form:install --bootstrap
  ```
