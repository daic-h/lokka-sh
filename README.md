# lokka-sh

lokka-sh is a mini shell for CMS Lokka that provides a uniform and quick access to commands.

# Build Status

<img src="https://secure.travis-ci.org/daic-h/lokka-sh.png"/>

## Install

    $ gem install lokka-sh

## Usage

    $ cd your-lokka-app
    $ lokka-sh

## Examples

Execute rake task:

    lokka> rake db:migrate

Run console:

    lokka> lokka console

## Commands

please type help

## Configuration

lokka-sh will try to load '~/lokkashrc' as configuration.

Example:

    # ~/lokkashrc
    Lokka::Sh::Command.define 'my_command' do |arg|
      puts "Execute my_command with arg(`#{arg}`)!"
    end

## Acknowledge

This library was allowed to fork jugyo/rails-sh.

It is gratitude to Mr.jugyo who exhibited the wonderful library.

## Copyright

Copyright (c) 2012 Daichi Hirata. See LICENSE.txt for further details.