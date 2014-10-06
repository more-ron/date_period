# DatePeriod

DatePeriod provides classes for date related periods.

```ruby
feb_1982 = DatePeriod::Month.new(year: 1982, month: 2) #=> Feb 1982

# date/time period conversion
feb_1982.date_period #=> Mon, 01 Feb 1982..Sun, 28 Feb 1982
feb_1982.time_period #=> 1982-02-01 00:00:00..1982-02-28 23:59:59

# computability and comparability
jan = feb_1982 - 1.month #=> Jan 1982
mar = feb_1982 + 1.month #=> Mar 1982
(jan + 2.months) == mar #=> true

# rangeability
year_1982 = DatePeriod::Month.new(year: 1982, month: 1) .. DatePeriod::Month.new(year: 1982, month: 12) #=> Jan 1982..Dec 1982
year_1982.include? feb_1982 #=> true
year_1982.include? Date.new(1982,2,19) #=> true
```

Implemented:

* `DatePeriod::Month`

Future implementation plans:

* `DatePeriod::Year`
* `DatePeriod::Quarter`
* `DatePeriod::Semi`
* `DatePeriod::Week`
* `DatePeriod::Decade`
* `DatePeriod::Century`
* `DatePeriod::Millenium`

## Installation

Add this line to your application's Gemfile:

    gem 'date_period'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install date_period

## Usage


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
