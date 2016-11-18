%w(
  json
  thread
  readline
  date
  active_support/deprecation
  active_support/dependencies/autoload
  active_support/core_ext
  active_support/dependencies
  active_support/cache
  em-twitter
  notify
  ap
  launchy
  oauth
  twitter_oauth
  yaml
).each { |lib| require lib }

Thread.abort_on_exception = true
Encoding.default_external = Encoding.find('UTF-8')

%w(
  ext
  core
  cache
  output
  input
  get_access_token
  twitter
  help
  commands
  id_var
).each { |name| require_dependency File.expand_path("../earthquake/#{name}", __FILE__) }
