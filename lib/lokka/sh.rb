require 'readline'
require 'stringio'
require 'rake/dsl_definition'
require 'rake'

module Lokka
  module Sh
    autoload :VERSION,  "lokka/sh/version"
    autoload :Color,    "lokka/sh/color"
    autoload :Prompt,   "lokka/sh/prompt"
    autoload :Helpers,  "lokka/sh/helpers"
    autoload :Forkable, "lokka/sh/forkable"
    autoload :Sinatra,  "lokka/sh/sinatra"
    autoload :Rake,     "lokka/sh/rake"
    autoload :Command,  "lokka/sh/command"
    autoload :Bundler,  "lokka/sh/bundler"

    def self.start
      Color.with(:cyan) { "Lokka.env: #{::Lokka.env}\n`help` to print help" }
      Rake.init
      load_commands
      Prompt.invoke
    end

    def self.load_commands
      require 'lokka/sh/commands'
      lokkashrc = "#{::Lokka.root}/.lokkashrc"
      load lokkashrc
      Color.with(:blue) {"load #{lokkashrc}"}
    rescue LoadError
    end
  end
end
