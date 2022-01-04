# frozen_string_literal: true

require_relative "rulers/version"
require_relative "rulers/routing"
require 'rulers/array'

module Rulers
  class Error < StandardError; end

  class Application
    def call(env)
      if env['PATH_INFO'] == '/' 
        return [301, {'Content-Type' => 'text/html', 'Location' => 'http://google.com'}, ["Yay! You're running Ruby On Rulers B)"]]
      end
      return [404, {'Content-Type' => 'text/html'}, []] if env['PATH_INFO'] == '/favicon.ico' 
      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      begin
        text = controller.send(act)
        [200, {'Content-Type' => 'text/html'}, [text]]
      rescue
        [500, {'Content-Type' => 'text/html'}, ["Bad stuff hapnd"]]
      end
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
