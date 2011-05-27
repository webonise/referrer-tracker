# Include hook code here
require File.join(File.dirname(__FILE__), "lib", "referrer_tracker")

#
#load the configutraions from yml
ReferrerTracker::Utils.load_configuration_yaml

#
#load models
path = File.join(File.dirname(__FILE__), 'lib', 'app', "models", "track.rb")
$LOAD_PATH << path
ActiveSupport::Dependencies.load_file(path)
