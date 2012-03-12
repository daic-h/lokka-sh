LokkaSh::Command.define 'help' do
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

LokkaSh::Command.define 'lokka' do |arg|
  LokkaSh::Sinatra.invoke(arg)
end

LokkaSh::Command.define 'rake' do |arg|
  LokkaSh::Rake.invoke(arg)
end

LokkaSh::Command.define 'tasks', 't' do |arg|
  Rake::Task.tasks.each do |task|
    puts task.name
  end
end

LokkaSh::Rake.task_names.map do |name|
  LokkaSh::Command.completions << "rake #{name}"
end

LokkaSh::Command.define 'bundle' do |arg|
  LokkaSh::Bundler.invoke(arg)
end

(LokkaSh::Bundler.sub_commands - ['init']).map do |c|
  LokkaSh::Command.completions << "bundle #{c}"
end

LokkaSh::Command.define '!' do |arg|
  system arg
end

LokkaSh::Command.define 'eval' do |arg|
  Color.with(:blue) { "=> #{eval(arg, binding, __FILE__, __LINE__).inspect}" }
end

LokkaSh::Command.define 'log' do |arg|
  Color.with(:r_video) { "Ctrl-C to quit" }
  system 'tail', '-f', Lokka.root + "tmp/#{(arg || 'development')}.log"
end

LokkaSh::Command.completions += %w(development test production).map { |i| "log #{i}" }

LokkaSh::Command.define 'exit' do
  exit
end

LokkaSh::Command.define 'restart' do
  puts 'restarting...'
  exec File.expand_path('../../../../bin/lokka-sh', __FILE__)
end

=begin
LokkaSh::Command.define 'reload' do
  LokkaSh::Sinatra.reload!
end
=end
