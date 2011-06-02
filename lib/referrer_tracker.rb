
class ActionController::Base
  before_filter :notice_referrer
end

require 'referrer_tracker/utils'
require 'app/models/referrer_tracker/referrer_track'

module ReferrerTracker
  include ReferrerTracker::Utils

  #
  # This is being called by basic before filter and used to check if conditions from config satisfies..
  #
  #
  def notice_referrer
    if config_actions.include?(current_c_a_pair)
      create_track_value
    end
  end

  #
  # Checks for correct configuratios and saves track.
  #
  # 
  def create_track_value
    if step==1
      create_for_step(1, current_source_value) if conversion_rate? && source_match?
      session[current_source_key] = current_source_value
    end
    if step!=1
      create_for_step(2, session[current_source_key])
      session[current_source_key] = nil
    end
  end

  #
  # Called to save the track
  #
  def create_for_step(step, source)
    ReferrerTrack.create(:step => step,
                 :track => current_track,
                 :source => source )
  end

end
