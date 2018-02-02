$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'lab_bot'

SlackRubyBot::App.instance.run
