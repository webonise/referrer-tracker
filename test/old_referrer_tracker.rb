# ReferrerTracker

class ActionController::Base
  before_filter :note_referrer
  after_filter :save_referrer
end


module ReferrerTracker
  class NotConfigured < Exception; end

  class << self
    attr_accessor :conf
  end

  def self.conf
    @conf || raise_unconfigured_exception
  end

  def note_referrer
    logger.info("+===========+++++++++===++++++++===++++++++====+++++===+++++=+++=+++==+++=++++=+++==+++=+++==+++==++++")
    logger.info(params["action"])
    logger.info(controller.inspect)
    logger.info(ReferrerTracker.conf.inspect)

    configurations = ReferrerTracker.conf
    controller_action = [params[:controller], params[:action]].join("#")
    conf_actions = get_yml_attributes("start_action")
    logger.info(controller_action)


    if conf_actions.include?(controller_action)
      logger.info("=====+++++++++++=====++++++=====+++++++=")
      logger.info("inside if of note_referrer")

      current_configuration = configurations["#{get_current_config_key(controller_action)}"]
      logger.info(current_configuration.inspect)
      source = current_configuration["referral_parameter"]
      logger.info(current_configuration["referral_parameter"])
      session[source.to_sym] = params[source.to_sym] if params[source.to_sym].present?
    end

  end

  def save_referrer
    logger.info(session[:sr])
    logger.info("@tracker_resource.inspect")
    logger.info(@tracker_resource.inspect)
    if session[:sr].present?
      logger.info("saving referrer as "+ session[:sr])
      Track.create(:source => session[:sr], :resource_id => user.id, :resource_type => user.class.to_s)
      session[:sr] = nil
    end

  end

  def self.raise_unconfigured_exception
    raise NotConfigured.new("No configuration provided for Referrer Tracker.")
  end

  def self.load_facebooker_yaml
    config = YAML.load(File.read(File.join(Rails.root,"config","referrer_tracker.yml")))
    raise NotConfigured.new("Unable to load configuration for #{::Rails.env} from referrer_tracker.yml. Is it set up?") if config.nil?
    self.conf = config#.with_indifferent_access
  end

  def get_yml_attributes(action)
    ReferrerTracker.conf.values.map{|i| i["#{action}"]}
  end

  def get_current_config_key(controller_action)
    result = ""
    ReferrerTracker.conf.each_pair do |k, v|
      if v.has_value?(controller_action) and !result.present?
        result = k
      end
    end
    result
  end
end


#Load the model files.
path = File.join(File.dirname(__FILE__), 'app', "models", "track.rb")
$LOAD_PATH << path
ActiveSupport::Dependencies.load_file(path)
