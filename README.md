# Interactor::Initializer

[![Build Status](https://secure.travis-ci.org/vinted/interactor-initializer.png)](http://travis-ci.org/vinted/interactor-initializer)
[![Gem Version](https://badge.fury.io/rb/interactor-initializer.png)](http://badge.fury.io/rb/interactor-initializer)

Dry interactor initializer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'interactor-initializer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install interactor-initializer

## Usage

Example:

```ruby
class Vouchers::Issue
 include Interactor::Initializer

 initialize_with :user

 def run
   puts "Voucher issued for #{user.full_name}"
 end
end
```

```ruby
Vouchers::Issue.for(user)
=> Voucher issued for Jonas Jonaitis
```

Interactor could be called with: `.for`, `.with` or `.run`

if keyword params are needed:
`initialize_with_keyword_params` should be used instead of `initialize_with`

```ruby
initialize_with_keyword_params :user
Vouchers::Issue.for(user: good_user)
```
