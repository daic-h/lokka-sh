require 'spec_helper'

describe LokkaSh::Command do
  before do
    LokkaSh::Command.clear
  end

  context 'when define a command' do
    before do
      @block = lambda {}
      LokkaSh::Command.define('foo', &@block)
    end

    it 'We can find it' do
      LokkaSh::Command.find('foo').should eq(@block)
    end

    it 'We can find nil with wrong name' do
      LokkaSh::Command.find('bar').should eq(nil)
    end

    it 'We can get command names' do
      LokkaSh::Command.command_names.should =~ [:foo]
    end

    describe 'Command.[]' do
      it 'can get a command' do
        LokkaSh::Command['foo'].should eq(@block)
      end
    end
  end

  describe '.completions' do
    context 'when command does not exist' do
      it 'completions is empty' do
        LokkaSh::Command.completions.should be_empty
      end
    end

    context 'when commands exist' do
      before do
        LokkaSh::Command.define('foo') {}
        LokkaSh::Command.define('bar') {}
      end

      it 'completions is empty' do
        LokkaSh::Command.completions.should =~ ['foo', 'bar']
      end
    end
  end

  describe '.completion_proc' do
    before do
      ['foo', 'lokka generate', 'rake routes', 'rake spec'].each { |c| LokkaSh::Command.completions << c }
    end

    it 'return completions' do
      LokkaSh::Command.completion_proc.call('foo').should =~ ['foo']
      LokkaSh::Command.completion_proc.call('rake').should =~ ['rake routes', 'rake spec']
    end

    context 'with blocks for completion' do
      before do
        LokkaSh::Command.completions.clear
        LokkaSh::Command.completions << lambda { |line| 'block' }
      end

      it 'return completions' do
        LokkaSh::Command.completion_proc.call('foo').should =~ ['block']
      end
    end
  end
end
