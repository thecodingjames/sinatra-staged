require "sinatra/base"

require "sinatra/namespace"
require "sinatra/content_for"

require "rack-livereload"

module Sinatra
    module Staged
        class AppController < Sinatra::Base
            use Rack::LiveReload, no_swf: true # TODO: Only in dev

            helpers  Sinatra::ContentFor
            register Sinatra::Namespace

            set :views, File.join(Dir.pwd, "views")

            def view(name)
                dir = File.basename caller.first.split(":").first
                # TODO: Use router
                p Sinatra::Staged.router

                slim File.join(dir.sub("_controller.rb", ""), name.to_s).to_sym  
            end
        end
    end
end
