$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'lab_bot'

namespace :db do
  desc 'Run DB migrations'
  task :migrate do
    LabBot::Db.migrate
  end

  desc 'Rollback the DB'
  task :rollback do
    LabBot::Db.rollback
  end
end
