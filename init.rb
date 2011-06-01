# Include hook code here
require File.join(File.dirname(__FILE__), "lib", "referrer_tracker")
require File.join(File.dirname(__FILE__), "lib", "referrer_tracker", "utils")

#
#load the configutraions from yml
ReferrerTracker::Utils.load_configuration_yaml

#
# load models - ReferrerTracker model
#
path = File.join(File.dirname(__FILE__), 'lib', 'app', "models", "track.rb")
$LOAD_PATH << path
ActiveSupport::Dependencies.load_file(path)
