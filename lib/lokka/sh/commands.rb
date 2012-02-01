include Lokka::Sh

Command.define 'help' do
  Color.with(:cyan) do
<<HELP
help             -> print help
lokka console    -> starting console
rake TASK        -> execute rake task
t, tasks PATTERN -> print rake tasks
bundle           -> execute bundler command
exit             -> exit from lokka-sh
restart          -> restart lokka-sh
!                -> execute a system command
eval             -> eval as ruby script
TODO: reload
HELP
  end
end

Command.define 'lokka' do |arg|
  Lokka::Sh::Sinatra.invoke(arg)
end

Command.define 'rake' do |arg|
  Lokka::Sh::Rake.invoke(arg)
end

Command.define 'tasks', 't' do |arg|
  Rake::Task.tasks.each do |task|
    puts task.name
  end
end

Lokka::Sh::Rake.task_names.map do |name|
  Command.completions << "rake #{name}"
end

Command.define 'bundle' do |arg|
  Lokka::Sh::Bundler.invoke(arg)
end

(Lokka::Sh::Bundler.sub_commands - ['init']).map do |c|
  Command.completions << "bundle #{c}"
end

Command.define '!' do |arg|
  system arg
end

Command.define 'eval' do |arg|
  Color.with(:blue) { "=> #{eval(arg, binding, __FILE__, __LINE__).inspect}" }
end

Command.define 'log' do |arg|
  Color.with(:r_video) { "Ctrl-C to quit" }
  system 'tail', '-f', Lokka.root + "tmp/#{(arg || 'development')}.log"
end

Command.completions += %w(development test production).map { |i| "log #{i}" }

Command.define 'exit' do
  exit
end

Command.define 'restart' do
  puts 'restarting...'
  exec File.expand_path('../../../../bin/lokka-sh', __FILE__)
end

=begin
Command.define 'reload' do
  Lokka::Sh::Sinatra.reload!
end
=end
