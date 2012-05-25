quotr
=====

Retrieves historical stock &amp; mutual fund quotes

what?
-----

This gem currenly does one thing only, retrieves historical closing prices for stocks, mutual funds, and ETFs.

where?
------

It retrieves historical prices from the Yahoo! finance API

how?
----

```ruby
closing_price = Quotr.close(:GOOG, Date.new(2012, 5, 11))  # => BigDecimal("605.23")
```

why?
----

I couldn't find a gem that could retrieve historical quotes for stocks AND mutual funds
