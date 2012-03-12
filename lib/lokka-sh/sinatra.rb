module LokkaSh
  module Sinatra
    extend Forkable

    class << self
      def init
      end

      def _invoke(line)
        case line
        when "console"
          require 'irb'
          IRB.start(Lokka.root)
        else
          raise
        end
      end

      def reload!
      end

      def sub_commands
        %w(console)
      end
    end
  end
end
