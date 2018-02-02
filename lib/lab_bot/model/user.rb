require 'sequel'

module LabBot
  module Model
    class User < Sequel::Model
      def self.from_slack_id(slack_id)
        User.first(slack_id: slack_id)
      end

      def self.load_from_user_hash(data)
        params = { slack_id: data[:id], name: data[:name], real_name: data[:real_name] }
        User.update_or_create(params)
      end

      def display_name
        if real_name && !real_name.empty?
          real_name
        else
          "@#{name}"
        end
      end
    end
  end
end
