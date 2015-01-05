require 'thread_hazardous/version'

if !defined?(RUBY_ENGINE) || RUBY_ENGINE == 'ruby'
  require 'thread_hazardous/mri_cache_backend'
else
  STDERR.puts('thread_hazardous is a noop when not running on MRI')
end
