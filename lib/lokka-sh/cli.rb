module LokkaSh
  module CLI
    class << self
      def run
        LokkaSh::Color.with(:cyan) do
          "Lokka.env: #{::Lokka.env}\n`help` to print help"
        end
        Rake.init
        load_commands
        LokkaSh::Prompt.invoke
      end

      def load_commands
        begin
          lokkashrc = "#{::Lokka.root}/.lokkashrc"
          load lokkashrc
          LokkaSh::Color.with(:blue) do
            "load #{lokkashrc}"
          end
        rescue LoadError => e
        end
      end
    end
  end
end

