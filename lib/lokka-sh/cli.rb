module Lokka
  module CLI
    class << self

      def run
        Color.with(:cyan) do
          "Lokka.env: #{::Lokka.env}\n`help` to print help"
        end
        Rake.init
        load_commands
        Prompt.invoke
      end

      def load_commands
        require "lokka-sh/commands"
        begin
          lokkashrc = "#{::Lokka.root}/.lokkashrc"
          load lokkashrc
          Color.with(:blue) {"load #{lokkashrc}"}
        rescue LoadError
        end
      end

    end
  end
end

