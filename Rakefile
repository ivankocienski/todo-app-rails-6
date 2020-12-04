# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

desc 'Run SimpleCove rspec check'
task :coverage do
    # ENV['COVERAGE'] = 'true'
    # Rake::Task['spec'].invoke
    system 'COVERAGE=true rspec'
end

task default: %i[coverage lint]