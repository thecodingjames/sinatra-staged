# rackup -I ../../lib

require "sinatra/staged"

run Sinatra::Staged::build(root_controller: :MainController)
