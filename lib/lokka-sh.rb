$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'readline'
require 'stringio'
require 'rake/dsl_definition'
require 'rake'

require 'lokka-sh/version'
require 'lokka-sh/color'
require 'lokka-sh/prompt'
require 'lokka-sh/helpers'
require 'lokka-sh/forkable'
require 'lokka-sh/sinatra'
require 'lokka-sh/rake'
require 'lokka-sh/bundler'
require 'lokka-sh/command'
require 'lokka-sh/command/define'
require 'lokka-sh/cli'

