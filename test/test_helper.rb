require 'thread_safe'

cache_path = ThreadSafe::Cache.instance_method(:initialize).source_location.first
THREAD_SAFE_PATH = File.expand_path('../..', File.dirname(cache_path))

require 'thread_hazardous'

def run_thread_safe_gem_tests(suite, except: [])
  require "#{THREAD_SAFE_PATH}/test/#{suite}.rb"

  unless except.empty?
    class_name = suite.sub(/^[a-z\d]*/) { $&.capitalize }.gsub(/(?:_|(\/))([a-z\d]*)/i) { $2.capitalize }
    test_class = Object.const_get(class_name)
    except.each do |method|
      test_class.send(:define_method, method) { skip("#{method} is not relevant in a non-threaded environment") }
    end
  end
end
