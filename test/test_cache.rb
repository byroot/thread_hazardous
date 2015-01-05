require File.join(File.dirname(__FILE__), "test_helper")

run_thread_safe_gem_tests('test_cache', except: %w(
  test_compute_if_absent_atomicity
  test_each_pair_allows_modification
))
