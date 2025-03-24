require "rack"

require_relative "staged/app_controller"
require_relative "staged/router"

module Sinatra
    module Staged

        def self.app_dir
            @@app_dir
        end

        def self.router
            @@router
        end

        def self.build(root_controller:)
            
            # Consider root path at config.ru
            @@app_dir = File.dirname caller.first
            @@router = Router.new root_controller: root_controller

            return Rack::Builder.app do

                root = @@router.root

                @@router.routes.each do |route|
                    map "/#{route.path}" do
                        run route.klass
                    end
                end

                if root.empty?
                    run Proc.new { |env| [404, {'content-type' => 'text/html'}, [<<~HTML]] }
                        <h1>Route not found</h1>
                        <p>Make sure to provide a corresponding controller</p>

                        <h2>Did you specify a <i>root</i> controller?</h2>
                        <p>Override <i>root?</i> in correspondig file</p>

                        <code><pre>
                        class HomeController < AppController

                          def self.root?
                              true
                          end

                        end
                        </pre></code>
                    HTML
                elsif root.length > 1
                    run Proc.new { |env| [404, {'content-type' => 'text/html'}, [<<-HTML]] }
                        <h1>Multiple root controller</h1>
                        <p>Make sure only one controller overrides <i>root?</i></p>
                    HTML
                else
                    run root.first.klass
                end

                map "/__routes__" do
                    run Proc.new { |env| [404, {'content-type' => 'text/html'}, [<<-HTML]] }
                        <h1>Root</h1>
                        #{ root.map { |r| "#{r.path} => #{r.klass}" }.join("<br>") }

                        <h1>Routes</h1>
                        #{ routes.map { |r| "#{r.path} => #{r.klass}" }.join("<br>") }
                    HTML
                end

            end
        end
    end
end
