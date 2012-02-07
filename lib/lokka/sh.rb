require 'readline'
require 'lokka/sh/version'
require 'lokka/sh/color'
require 'lokka/sh/helpers'
require 'lokka/sh/forkable'
require 'lokka/sh/sinatra'
require 'lokka/sh/rake'
require 'lokka/sh/command'
require 'lokka/sh/bundler'

module Lokka
  module Sh
    class << self
      def initializer
        ::Lokka::Sh::Rake.init

        require 'lokka/sh/commands'
        begin; load "#{::Lokka.root}/.lokkashrc"; rescue LoadError; end
      end

      def start
        initializer
        Color.with(:cyan) { "Lokka.env: #{::Lokka.env}\n`help` to print help" }
        setup_readline
        while buf = Readline.readline(prompt, true)
          line = buf.strip
          next if line.empty?
          begin
            execute(line)
          rescue SystemExit
            raise
          rescue Exception => e
            Color.with(:bg_red) { "#{e.message}\n#{e.backtrace.join("\n")}" }
          end
        end
        setup_readline
      end
    end

    def prompt
      "%s> " % "lokka-sh(#{File.basename(::Lokka.root)})"
    end

    def setup_readline
      Readline.basic_word_break_characters = ""
      Readline.completion_proc = Command.completion_proc
    end

    def execute(line)
      if command = Command.find(line)
        start = Time.now
        arg = line.split(/\s+/, 2)[1] rescue nil
        command.call(arg)
        Color.with(:blue) { "#{Time.now - start}sec" }
      else
        Color.with(:bg_red) { "Command not found" }
      end
    end
  end
end
