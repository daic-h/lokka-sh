module Lokka
  module Sh
    module Prompt
      extend self

      def invoke
        setup_readline

        while buf = Readline.readline(prompt, true)
          line = buf.strip
          next if line.empty?
          begin
            execute(line)
          rescue SystemExit
            raise
          rescue Exception => e
            Lokka::Sh::Color.with(:bg_red) { "#{e.message}\n#{e.backtrace.join("\n")}" }
          end
        end

        setup_readline
      end

      def prompt
        "%s> " % "lokka-sh(#{File.basename(::Lokka.root)})"
      end

      def setup_readline
        Readline.basic_word_break_characters = ""
        Readline.completion_proc = Lokka::Sh::Command.completion_proc
      end

      def execute(line)
        if command = Lokka::Sh::Command.find(line)
          start = Time.now
          arg = line.split(/\s+/, 2)[1] rescue nil
          command.call(arg)
          Lokka::Sh::Color.with(:blue) { "#{Time.now - start}sec" }
        else
          Lokka::Sh::Color.with(:bg_red) { "Command not found" }
        end
      end
    end
  end
end
