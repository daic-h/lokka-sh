require 'spec_helper'

describe Lokka::Sh::Command do
  before do
    Lokka::Sh::Command.clear
  end

  context 'when define a command' do
    before do
      @block = lambda {}
      Lokka::Sh::Command.define('foo', &@block)
    end

    it 'We can find it' do
      Lokka::Sh::Command.find('foo').should eq(@block)
    end

    it 'We can find nil with wrong name' do
      Lokka::Sh::Command.find('bar').should eq(nil)
    end

    it 'We can get command names' do
      Lokka::Sh::Command.command_names.should =~ [:foo]
    end

    describe 'Command.[]' do
      it 'can get a command' do
        Lokka::Sh::Command['foo'].should eq(@block)
      end
    end
  end

  describe '.completions' do
    context 'when command does not exist' do
      it 'completions is empty' do
        Lokka::Sh::Command.completions.should be_empty
      end
    end

    context 'when commands exist' do
      before do
        Lokka::Sh::Command.define('foo') {}
        Lokka::Sh::Command.define('bar') {}
      end

      it 'completions is empty' do
        Lokka::Sh::Command.completions.should =~ ['foo', 'bar']
      end
    end
  end

  describe '.completion_proc' do
    before do
      ['foo', 'lokka generate', 'rake routes', 'rake spec'].each { |c| Lokka::Sh::Command.completions << c }
    end

    it 'return completions' do
      Lokka::Sh::Command.completion_proc.call('foo').should =~ ['foo']
      Lokka::Sh::Command.completion_proc.call('rake').should =~ ['rake routes', 'rake spec']
    end

    context 'with blocks for completion' do
      before do
        Lokka::Sh::Command.completions.clear
        Lokka::Sh::Command.completions << lambda { |line| 'block' }
      end

      it 'return completions' do
        Lokka::Sh::Command.completion_proc.call('foo').should =~ ['block']
      end
    end
  end
end
