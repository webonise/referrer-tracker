namespace :db do
  namespace :migrate do
    description = "Migrate the database through scripts in vendor/plugins/referrel_tracker/lib/db/migrate"
    description << "and update db/schema.rb by invoking db:schema:dump."
    description << "Target specific version with VERSION=x. Turn off output with VERBOSE=false."

    desc description
    task :rt_setup => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate("vendor/plugins/referrer_tracker/lib/db/migrate/", ENV["VERSION"])
      Rake::Task["db:migrate"].execute
      Rake::Task["db:schema:dump"].invoke
    end
  end

  namespace :rollback do
    description = "Migrate the database through scripts in vendor/plugins/referrel_tracker/lib/db/migrate"
    description << "and update db/schema.rb by invoking db:schema:dump."
    description << "Target specific version with VERSION=x. Turn off output with VERBOSE=false."

    desc description
    task :rt_rollback => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate("vendor/plugins/referrer_tracker/lib/db/migrate/", ENV["VERSION"])
      Rake::Task["db:rollback"].execute
      Rake::Task["db:schema:dump"].invoke
    end
  end
end