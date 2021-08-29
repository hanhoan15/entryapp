# README

This is a super small webapp using rails, ruby, sqlite.

Additional information:
* ruby 2.6.0
* rails 6.1.4.1

Install
* `cd/entryapp`
* `bundle install`
* `bin/rails server`

Unit test
* `bundle exec rake rspec spec/models/entry_spec.rb  `
* `bundle exec rspec spec/serializer/entry_serializer_spec.rb`
* `bundle exec rspec spec/service/entry_service_spec.rb`
* `bundle exec rspec spec/controllers/entries_controller_spec.rb`
* `bundle exec rspec spec/models/entry_spec.rb`