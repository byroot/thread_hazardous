require 'thread_safe/cache'

# All MriCacheBackend methods are just synchronizing a mutex before calling the parent implementation
# In a non thread safe environment it is simply a waste of time.
ThreadSafe::MriCacheBackend.public_instance_methods(false).each do |method|
  ThreadSafe::MriCacheBackend.send(:define_method, method, ThreadSafe::NonConcurrentCacheBackend.instance_method(method))
end

class ThreadSafe::MriCacheBackend
  # The original implementation duplicate the `@backend` Hash so it do not have to lock during the full iteration
  def each_pair
    @backend.each_pair do |k, v|
      yield k, v
    end
    self
  end
end
