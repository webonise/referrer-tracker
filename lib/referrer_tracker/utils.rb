module ReferrerTracker::Utils

  class NotConfigured < Exception; end

  class << self
    attr_accessor :conf
  end


  # to give current pairs order in list of actions
  def step
    number = ReferrerTracker::Utils.conf[current_track]["actions"].split.find_index(current_c_a_pair)
    number.nil? ? 0 : number+1
  end


  # to get value of current source value specified with referrer_parameter
  def current_source_value
    params[get_yml_attributes("referrer_parameter").to_s.to_sym]
  end


  # to get value of current source key specified with referrer_parameter
  def current_source_key
    get_yml_attributes("referrer_parameter").to_s.to_sym
  end


  # checks value for conversion rate
  def conversion_rate?
    get_yml_attributes("conversion_rate").first
  end


  #
  # Returns array of controller-action pairs present in .yml conf file.
  def config_actions
    get_yml_attributes("actions").map{|i| i.split}.flatten
  end


  #
  # get current track here
  def current_track
    result = ""
    ReferrerTracker::Utils.conf.each_pair do |k, v|
      if v["actions"].split.include?(current_c_a_pair) and !result.present?
        result = k
      end
    end
    result
  end


  #
  # Gives current controller action pair
  def current_c_a_pair
     [params[:controller], params[:action]].join("#")
  end


  #
  # Getter methods over module got get conf,
  # raises NotConfigured, if nil
  def self.conf
    @conf || raise_unconfigured_exception
  end


  #
  # NotConfigured exception rising class
  def self.raise_unconfigured_exception
    raise NotConfigured.new("No configuration provided for Referrer Tracker.")
  end


  #
  # Loads configuration from yml file. called at application start.
  #
  def self.load_configuration_yaml
    config = YAML.load(File.read(File.join(Rails.root,"config","referrer_tracker.yml")))
    raise NotConfigured.new("Unable to load configuration for #{::Rails.env} from referrer_tracker.yml. Is it set up?") if config.nil?
    self.conf = config#.with_indifferent_access
  end


  #
  # Give Attributes from yml file
  def get_yml_attributes(action)
    ReferrerTracker::Utils.conf.values.map{|i| i["#{action}"]}
  end


  #
  # This is to check if current referrer key is the one defined in configs.
  #
  #
  def source_match?
      params[current_source_key.to_sym].present?
  end

end