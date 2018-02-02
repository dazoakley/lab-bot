require 'sequel'

module LabBot
  module Model
    class Channel < Sequel::Model
      def self.from_slack_id(slack_id)
        Channel.first(slack_id: slack_id)
      end

      def self.load_from_channel_hash(data)
        params = {
          slack_id: data[:id],
          name:     data[:name],
          archived: data[:is_archived],
          private:  data[:is_private]
        }

        Channel.update_or_create(params)
      end

      def self.active_channels
        Channel.where(archived: false)
      end

      def self.active_public_channels
        Channel.active_channels.where(private: false)
      end
    end
  end
end
