module LokkaSh::Command
  define 'help' do
    LokkaSh::Color.with(:blue) do
      <<HELP
help             -> print help
console          -> starting console
rake TASK        -> execute rake task
tasks PATTERN    -> print rake tasks
bundle           -> execute bundler command
exit             -> exit from lokka-sh
restart          -> restart lokka-sh
!                -> execute a system command
eval             -> eval as ruby script
HELP
    end
  end

  define 'console' do
    LokkaSh::Sinatra.invoke('console')
  end

  define 'rake' do |arg|
    LokkaSh::Rake.invoke(arg)
  end

  define 'tasks', 't' do |arg|
    Rake::Task.tasks.each do |task|
      puts task.name
    end
  end

  LokkaSh::Rake.task_names.map do |name|
    self.completions << "rake #{name}"
  end

  define 'bundle' do |arg|
    LokkaSh::Bundler.invoke(arg)
  end

  (LokkaSh::Bundler.sub_commands - ['init']).map do |c|
    self.completions << "bundle #{c}"
  end

  define '!' do |arg|
    system arg
  end

  define 'eval' do |arg|
    LokkaSh::Color.with(:blue) { "=> #{eval(arg, binding, __FILE__, __LINE__).inspect}" }
  end

  define 'log' do |arg|
    LokkaSh::Color.with(:r_video) { "Ctrl-C to quit" }
    system 'tail', '-f', Lokka.root + "tmp/#{(arg || 'development')}.log"
  end

  self.completions += %w(development test production).map { |i| "log #{i}" }

  define 'exit' do
    exit
  end

  define 'restart' do
    puts 'restarting...'
    exec File.expand_path('../../../bin/lokka-sh', __FILE__)
  end
end
