module LokkaSh
  module Rake
    extend Forkable

    class << self
      def init
        $stdout = StringIO.new

        before_fork do
        end
        after_fork do
        end

        ::Rake.application = ::Rake::Application.new
        ::Rake.application.init
        ::Rake.application.load_rakefile
      ensure
        $stdout = STDOUT
      end

      def _invoke(line)
        line ||= 'default'
        name, *args = line.split(/\s+/)
        args.each do |arg|
          env, value = arg.split('=')
          next unless env && !env.empty? && value && !value.empty?
          ENV[env] = value
        end
        ::Rake.application[name].invoke
      end

      def task_names
        ::Rake.application.tasks.map{|t| t.name}
      end
    end
  end
end
