# ThreadHazardous

[![Build Status](https://travis-ci.org/byroot/thread_hazardous.svg)](http://travis-ci.org/byroot/thread_hazardous)
[![Gem Version](https://badge.fury.io/rb/thread_hazardous.png)](http://badge.fury.io/rb/byroot/thread_hazardous)

Monkey patch thread_safe to make it faster in non thread safe applications

**CAUTION: Use this gem at your own risk.**

If you use gems that depends on the `thread_safe` gem,
e.g. Rails, but your application is not doing any threading, then `thread_hazardous` can bring you a few performance
improvements at the cost of making these dependencies non thread safe.

## Explanation

`ThreadSafe::Cache` on MRI to provide thread safety wrap all it's method in a mutex.
Also to ensure the cache won't be modified during an iteration, it clones the instance. So each iteration allocate an extra object.


These operations themselves are not that costly, but they are often used in heavy hotspots, especially in Rails, so in the end it adds up.
Here's a profiling real life application under real life load:

```
==================================
  Mode: wall(1000)
  Samples: 15836 (0.35% miss rate)
  GC: 696 (4.40%)
==================================
TOTAL (pct)   SAMPLES (pct)   FRAME
419   (2.6%)    419   (2.6%)  ThreadSafe::NonConcurrentCacheBackend#[]
208   (1.3%)    208   (1.3%)  ThreadSafe::NonConcurrentCacheBackend#dupped_backend
 75   (0.5%)     75   (0.5%)  block in ThreadSafe::Cache#values
```


`thread_hazardous` simply monkey patch `ThreadSafe::Cache` to remove the mutex and not clone the instance on iteration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'thread_hazardous'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install thread_hazardous

## Usage

Nothing more to do, it's all automatic.

## Contributing

1. Fork it ( https://github.com/byroot/thread_hazardous/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
