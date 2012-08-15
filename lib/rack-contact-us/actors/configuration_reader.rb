module ContactUs
  class ConfigurationReader
    def call(configuration_string)
      config = YAML.load(configuration_string)
      config.inject({}) do |hsh,(key,value)|
        hsh.merge key.to_sym => value
      end
    end
  end
end
