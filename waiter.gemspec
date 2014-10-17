Gem::Specification.new do |s|
  s.name        = 'waiter'
  s.version     = '0.0.1'
  s.date        = Time.now.utc.strftime("%Y-%m-%d")
  s.summary     = 'Waiter takes a block and keeps running it until it evaluates to true, pausing in-between and timing out eventually.'
  s.authors     = ['James']
  s.email       = 'james@example.com'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.homepage    = ''
  s.license     = 'MIT'
end
