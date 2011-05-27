
class ActionController::Base
  before_filter :notice_referrer
end

module ReferrerTracker
  include Utils

  def notice_referrer
    logger.info(session.inspect)
    logger.info(current_c_a_pair)
    logger.info(params[:controller])
    logger.info(params[:action])
    logger.info(request.env['URL'])
    logger.info(request.url)
#    url = Rails.application.routes.recognize_path(request.env['PATH_INFO'])
    url= Rails.application.routes.recognize_path(request.url)
    logger.info(url.inspect)

    logger.info(config_actions.inspect)
    if config_actions.include?(current_c_a_pair)
      create_track_value
    end
    logger.info(session.inspect)
  end


  def create_track_value
    logger.info("+=+++++++++++===+++++++=====+++++++==== step is " + step.to_s)
    if step==1
      create_for_step(1, current_source_value) if conversion_rate
      session[current_source_key] = current_source_value
    end
    if step!=1
      create_for_step(2, session[current_source_key])
      session[current_source_key] = nil
    end
  end


  def create_for_step(step, source)
    Track.create(:step => step,
                 :track => current_track,
                 :source => source )
  end

end
