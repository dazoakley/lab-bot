require 'sequel'

module LabBot
  module Model
    class Message < Sequel::Model
      many_to_one :user
      many_to_one :channel

      def self.store_message(data)
        # we only care about messages
        return unless data[:type] == 'message'

        # keep direct messages private
        return if data[:channel].start_with?('D')

        # ignore message "subtypes"
        return if data[:subtype]

        params = { user_id:    User.from_slack_id(data[:user]).id,
                   channel_id: Channel.from_slack_id(data[:channel]).id,
                   text:       data[:text],
                   ts:         data[:ts] }

        Message.create(params)
      end
    end
  end
end
