require File.expand_path("../lib/sinatra/staged/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "sinatra-staged"
  s.version     = Sinatra::Staged::VERSION
  s.summary     = "An opiniated Sinatra scaffold"
  s.description = "Scaffold a MVC Sinatra App using file-based routing, Slim templates and Sequel ORM"
  s.authors     = ["James Hoffman"]
  s.email       = "james@jhoffman.ca"
  s.homepage    = "https://github.com/thecodingjames/sinatra-staged"
  s.license     = "MIT"

  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'

  s.executables = ["sinatra-staged"]

  s.add_runtime_dependency "sinatra", "~> 4.1.0"
  s.add_runtime_dependency "sinatra-contrib", "~> 4.1.0"
  s.add_runtime_dependency "puma", "~> 6.5.0"
  s.add_runtime_dependency "rackup", "~> 2.2.0"
  s.add_runtime_dependency "slim", "~> 5.2.0"

  s.add_runtime_dependency "filewatcher-cli", "~> 1.1.0"
  s.add_runtime_dependency "foreman", "~> 0.88.0"
  s.add_runtime_dependency "rack-livereload", "~> 0.6.0"
  s.add_runtime_dependency "guard-livereload", "~> 2.5.0"
end
