#require 'rake'
#require 'rake/testtask'
#require 'rake/rdoctask'
#
#desc 'Default: run unit tests.'
#task :default => :test
#
#desc 'Test the referrer_tracker plugin.'
#Rake::TestTask.new(:test) do |t|
#  t.libs << 'lib'
#  t.libs << 'test'
#  t.pattern = 'test/**/*_test.rb'
#  t.verbose = true
#end
#
#desc 'Generate documentation for the referrer_tracker plugin.'
#Rake::RDocTask.new(:rdoc) do |rdoc|
#  rdoc.rdoc_dir = 'rdoc'
#  rdoc.title    = 'ReferrerTracker'
#  rdoc.options << '--line-numbers' << '--inline-source'
#  rdoc.rdoc_files.include('README')
#  rdoc.rdoc_files.include('lib/**/*.rb')
#end

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "referrer_tracker"
  gem.summary = %Q{Tracks the urls references.}
  gem.description = %Q{It pulls in the ?ref= and ?sr= type references from urls and marks visitor comings from those urls.}
  gem.email = "rtdp@weboniselab.com"
  gem.authors = ["rtdp"]
  gem.version = "0.1.5"
end
Jeweler::RubygemsDotOrgTasks.new
