# Algernon

[![Coverage Status](https://coveralls.io/repos/github/andela-ydaniju/algernon/badge.svg?branch=master)](https://coveralls.io/github/andela-ydaniju/algernon?branch=master) [![Build Status](https://travis-ci.org/andela-ydaniju/algernon.svg?branch=master)](https://travis-ci.org/andela-ydaniju/algernon) [![Code Climate](https://codeclimate.com/github/andela-ydaniju/algernon/badges/gpa.svg)](https://codeclimate.com/github/andela-ydaniju/algernon) [![Gem Version](https://badge.fury.io/rb/algernon.svg)](https://badge.fury.io/rb/algernon)

Algernon is a Ruby MVC web framework.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'algernon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install algernon

## Usage

Algernon is a tiny framewok built using the Rails way. It follows an MVC pattern. Models, Views and Controllers (MVC) are all systematically arranged in respective directories under the app directory.

```
Algernon Application
│   
└───app
|   └───assets
|   └───controllers
|   └───models
|   └───views
└───config
|    └─── routes.rb
|    └───application.rb
└───database
|    └───data.sqlite3
└───config.ru
```

At the moment, the only database supported is SQLite3.

## Initial Setup
Algernon is built using Rack - a simple interface between webservers that support Ruby and Ruby frameworks. Thus, web apps built with the framework are initialized same way Rack apps are initlialized - through a `config.ru` file, which is parsed to determine appropriate configuration settings. A sample `config.ru` is:

```ruby
APP_ROOT ||= __dir__

require File.expand_path("../config/application", __FILE__)

LapisTodoApp = LapisTodo::Application.new
require_relative "config/routes.rb"

app ||= Rack::Builder.new do
  use Rack::Reloader
  use Rack::Static, urls: ["/css", "/font-awesome", "/js", "/fonts", "/img"],
                    root: "app/assets"

  run LapisTodoApp
end

run app
```
Algernon

The first line of the sample config file requires the Algernon framework. 

The second line sets a constant used by the framework in searching for important files. This is required in order to map locations of important components in the web application. Thus it should be set by apps built on top of Algernon.  

A sample Application class which inherits from the Algernon::Application class is then declared and initialized. This sample class is used to start up the web server, and inherits methods from the BaseApplication class to provide a rack-compatible response to requests. The declaration for the Application class could be moved into a separate class and then required in the config file.

On instantiating the Application class, routes need to be set. In the ```routes.rb``` in the config direectory. A block with the route methods called appropriately is passed to the prepare method exposed by the application. This block is evaluated, and routes are saved for processing.

On the last line of the config file, the application is passed to the run method, which is evaluated by Rack to start up the web application on the default port - 9292.

## Key Features

### Routing
Routing with Algernon deals with directing requests to the appropriate controllers. A sample route file is: 

```ruby
LapisTodoApp.routes.draw do
  resources "tasks"
  root "tasks#index"
end
```

Algernon supports GET, DELETE, PATCH, POST, PUT requests. 

In the sample config file, the second line indicates that GET requests to the root path of the application should be handled by the `index action of the TasksController`.

Thus an appropriate view named index.html.erb in the fellows folder is expected in the views folder. Instance variables set in the index action of the controller are passed to the Erubis template engine which renders the view.

Resources creates a REST-compatible set of routes which handles CRUD requests dealing with fellows. The declaration is equivalent to writing these set of routes:

```ruby
get "/tasks", to: "tasks#index"
get "/tasks/new", to: "tasks#new"
post "/tasks", to: "tasks#create"
get "/tasks/:id", to: "tasks#show"
get "/tasks/:id/edit", to: "tasks#edit"
patch "/tasks/:id", to: "tasks#update"
put "/tasks/:id", to: "tasks#update"
delete "/tasks/:id", to: "tasks#destroy"
```


### Models
All models to be used with the Algernon framework are to inherit from the BaseRecord class provided by Algernon, in order to access the rich ORM functionalities provided. Although not as succinct as ActiveRecord, the BaseRecord class acts as an interface between the model class and its database representation. A sample model file is provided below:

```ruby
class Task < Algernon::Model
  to_table :tasks

  property :title, type: :varchar, nullable: false
  property :description, type: :text
  property :created_at, type: :datetime
  property :updated_at, type: :datetime

  create_table
end
```
The `to_table` method provided stores the table name used while creating the table record in the database. 

The `property` method is provided to declare table columns, and their attributes. The first argument to `property` is the column name, while subsequent hash arguments are used to provide information about attributes.

The `type` argument represents the data type of the column. Supported data types by Algernon are:

  * integer (for numeric values)
  * boolean (for boolean values [true or false])
  * text    (for alphanumeric values)

The `primary_key` argument is used to specify that the column should be used as the primary key of the table. If this is an integer, the value is auto-incremented by the database.

The `nullable` argument is used to specify whether a column should have null values, or not.

While creating models, the id property declaration is optional. If this is is not provided, the Algernon ORM adds it automatically, and sets it as the primary key. Thus, it should only be set if you'd like to use a different type as the primary key.

On passing in the table name, and its properties, a call should be made to the `create_table` method to persist the model to database by creating the table.


### Controllers
Controllers are key to the MVC structure, as they handle receiving requests, interacting with the database, and providing responses. Controllers are placed in the controllers folder, which is nested in the app folder.

All controllers should inherit from the BaseController class provided by Algernon to inherit methods which simplify accessing request parameters and returning responses by rendering views.

A sample structure for a controller file is:

```ruby
class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.create(task_params)
    redirect_to "/tasks/#{task.id}"
  end

  def show
    @task = Task.find(params[:id].to_i)
  end

  def edit
    @task = Task.find(params[:id].to_i)
  end

  def update
    @task = Task.find(params[:id].to_i)
    @task.update(task_params)
    redirect_to "/tasks/#{@task.id}"
  end

  def destroy
    Task.destroy(params[:id].to_i)
    redirect_to "/tasks"
  end

  def task_params
    parameters = {
      title: params[:title],
      description: params[:description],
      updated_at: Time.now.to_s
    }
    parameters[:created_at] = Time.now.to_s if params[:id].nil?
    parameters
  end
end
```

Instance variables set by the controllers are passed to the routes while rendering responses. 

Explicitly calling `render` to render template files is optional. If it's not called by the controller action, then it's done automatically by the framework with an argument that's the same name as the action. Thus, you can decide to call `render` explicitly when you want to render a view with a name different from the action.


### Views
Currently, view templates are handled with the Erubis template engine. See https://rubygems.org/gems/erubis for more details.

Views are mapped to actions in controllers. Thus the folder structure for storing views depends on the location of the controller/action. A view to be rendered for the new action in the TasksController for example is saved as `new.html.erb` in the tasks folder, nested in the views folder. A sample structure for a view file is:

```erb
<div class = "form-part container-fluid">
    <div class = "form-part-in row">
        <div class="col-xs-4">&nbsp;</div>
        <div class="">
          <h2 class="form-tag">Create Task</h2>
          <form class="" action="/tasks" method="post">
            <label for="title" class="sr-only">Title</label>
            <input type="text" id="title" class="form-control" placeholder="Title" name="title">
            <label for="description" class="sr-only">Description</label>
            <input type="text" id="description" class="form-control"  placeholder="Description" name="description">
            </div>
            <input class="btn btn-lg btn-primary btn-block" type="submit" value="Create Task"/>
          </form>
        </div>
        <div class="col-xs-4">&nbsp;</div>
    </div>
</div>
```

### External Dependencies
The Algernon framework has a few dependencies. These are listed below, with links to source pages for each.

  * sqlite3     - https://github.com/sparklemotion/sqlite3-ruby
  * erubis      - https://rubygems.org/gems/erubis
  * tilt        - https://github.com/rtomayko/tilt
  * bundler     - https://github.com/bundler/bundler
  * rake        - https://github.com/ruby/rake
  * rack        - https://github.com/rack/rack
  * rack-test   - https://github.com/brynary/rack-test

## Testing

Before running tests, run the following command to install dependencies

        $ bundle install

To test the web framework, run the following command to carry out all tests:

        $ bundle exec rake

## Contributing

1. Fork it by visiting - https://github.com/andela-ydaniju/algernon/fork

2. Create your feature branch

        $ git checkout -b new_feature
    
3. Contribute to code

4. Commit changes made

        $ git commit -a -m 'descriptive_message_about_change'
    
5. Push to branch created

       $ git push origin new_feature
    
6. Then, create a new Pull Request

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
