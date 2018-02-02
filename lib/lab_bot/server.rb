require 'slack-ruby-bot'
require 'json'
require 'pry'

require_relative 'db'

LabBot::Db.connect

require_relative 'model'

ENV['SLACK_RUBY_BOT_ALIASES'] = 'lab-bot labbot'

module LabBot
  # Bindings to the RTM API
  class Server < SlackRubyBot::Server
    on 'hello' do |client, data|
      client.channels.values.each { |channel| Model::Channel.load_from_channel_hash(channel) }
      client.users.values.each { |user| Model::User.load_from_user_hash(user) }
    end

    on 'message' do |client, data|
      Model::Message.store_message(data)
    end
  end

  # Simpler bot events
  class Bot < SlackRubyBot::Bot
    command 'channels' do |client, data, match|
      resp = "Here's the active public channels:\n\n"

      Model::Channel.active_public_channels.each do |channel|
        resp << "##{channel.name}\n"
      end

      client.say(text: resp, channel: data.channel)
    end

    help do
      title 'LabBot'
      desc "I'm your helpful bot"

      command 'channels' do
        desc 'List channels'
        long_desc 'Tells you what PUBLIC channels there are in this slack'
      end
    end
  end
end
