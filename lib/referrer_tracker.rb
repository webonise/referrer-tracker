
class ActionController::Base
  before_filter :notice_referrer
end

module ReferrerTracker
  include Utils

  def notice_referrer
    if config_actions.include?(current_c_a_pair)
      create_track_value
    end
  end


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


  def create_for_step(step, source)
    ReferrerTrack.create(:step => step,
                 :track => current_track,
                 :source => source )
  end

end
