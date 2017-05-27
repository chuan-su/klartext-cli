require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'standalone_migrations'
require 'klartext'

StandaloneMigrations::Tasks.load_tasks
RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :klartext do
  task :es_setup do
    before = Time.now
    es_client = Klartext::ESClient.new
    es_client.delete_index
    es_client.create_index
    es_client.update_mapping
    printf "took %.2fs\n", (Time.now - before)
  end
end
