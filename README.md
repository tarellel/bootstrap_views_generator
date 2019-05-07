# BootstrapViewsGenerator

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/bootstrap_views_generator`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bootstrap_views_generator', group: :development
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
-t, [--template-engine=TEMPLATE_ENGINE]     # Indicates when to generate template engine
                                            # Default: erb
-sf [--simpleform]                          # Indicates if simpleform will be used
                                            # Default: false
-p [--pagination]                           # Specify if you want to add pagination to the index pages
                                            # Defaults: false (requires Pagy to use pagination)
-m [--metatags]                             # If you want the pages titles to use the metatags gem function for the page title
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
gem 'pagy'
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
