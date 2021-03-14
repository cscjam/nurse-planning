# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :import do
  desc 'an import profiles test'
  task :patients => :environment do
    import = ImportUserCSV.new(path: "test/Profilestest.csv")
    import.run!
    pp import.report.message unless import.report.success?
  end
end

