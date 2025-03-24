require "singleton"

module Sinatra
    module Staged
        class Router

            attr_reader :root, :routes

            def initialize(root_controller:)
                app_dir = Sinatra::Staged.app_dir
                controllers = Dir.glob "controllers/**/*.*", base: app_dir

                controllers.each do |controller|
                    require_relative File.join(app_dir, controller)
                end

                route = Struct.new(:klass, :path, keyword_init: true)

                routes = controllers.map do |controller|
                    basename = File.basename controller, "_controller.rb"
                    dirname  = File.dirname(controller).sub(".", "")

                    class_name = basename.split("_").map(&:capitalize).join
                    path = basename.gsub "_", "-"

                    unless File.dirname(dirname) == path || dirname.empty?
                        path = File.join dirname, path
                    end

                    klass = Object.const_get("#{class_name}Controller")

                    route.new(klass: klass, path: path)
                end

                root_controller_class = Object.const_get root_controller

                @root = routes.select do |route|
                    route.klass == root_controller_class
                end

                @routes = routes.select do |route|
                    route.klass != root_controller_class
                end
            end

        end
    end
end
