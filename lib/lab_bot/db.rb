require 'sequel'
require 'json'

Sequel.database_timezone = :utc
Sequel.extension :migration
Sequel::Model.plugin :update_or_create
Sequel::Model.plugin :timestamps, update_on_create: true

module LabBot
  class Db
    def self.connect
      raise ArgumentError, 'You must set a DATABASE_URL environment variable' unless ENV['DATABASE_URL']
      @db ||= Sequel.connect(ENV['DATABASE_URL'])
    end

    def self.disconnect
      @db.disconnect if @db
      @db = nil
    end

    def self.migrate
      Sequel::Migrator.apply(connect, migrations_dir)
    end

    def self.rollback
      version = (row = connect[:schema_info].first) ? row[:version] : nil
      Sequel::Migrator.apply(connect, migrations_dir, version - 1)
    end

    def self.migrations_dir
      File.join(File.dirname(__FILE__), '../../db/migrations')
    end
  end
end
