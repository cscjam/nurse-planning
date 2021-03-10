# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

namespace :import do
  desc 'an import profiles test'
  task :patients => :environment do
    my_file = "test/Profilestest.CSV"
    import = ImportUserCSV.new(file: my_file)
    import.valid_header?
    import.report.message

    import.run!
    import.run.success?
    import.report.message
  end
end

