# RSpec-ColDep [![Build Status](https://secure.travis-ci.org/MDaubs/rspec-coldep.png?branch=master)](http://travis-ci.org/MDaubs/rspec-coldep)

Col(laborators) & Dep(endencies)

Syntax for specifing RSpec stubs and test doubles that mimicks how they are used.

This is an experiment to see if test setup code can more explicitly document the dependencies and collaborators of objects under test.

## Installation

Add this line to your application's Gemfile:

    gem 'rspec-coldep'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec-coldep

## Documenting dependencies stubs constants

RSpec-ColDep syntax documents dependencies of the object under test and creates stubs based on the example usage provided via block:

    dependency 'User' do
      User.find('1234') == 'a single fake user'
      User.all == 'a couple fake users'
    end

is similar to this:

    User.stub(:find).with('1234').and_return('a single fake user')
    User.stub(:all).and_return('a couple fake users')

except the ColDep version encourages test isolation by:

  * not requiring `User` to be previously defined.
  * not allowing unstubbed methods to be called on the dependency.

## Documenting collaborators builds test doubles

RSpec-ColDep syntax documents a collaborator's interface with the object under test and builds a test double based on the example usage provided via block:

    fake_user = collaborator do |user|
      user.first_name == 'Billy'
      user.last_name == 'Jean'
    end

is effectively the same as:

    fake_user = double(first_name: 'Billy', last_name: 'Jean')

## How is this beneficial?

This is just an experiment and may very well be a terrible idea. The thought that this gem explores is the ability to define dependencies and collaborating objects by writing code that documents how they are used without being litered by mocking framework method names like `stub`, `with`, `and_returns`, etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
