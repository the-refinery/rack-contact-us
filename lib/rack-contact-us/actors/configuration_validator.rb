class ConfigurationValidator
  def self.config_params; @config_params end
  def self.config_param(*params)
    @config_params =
      params.map do |param|
        attr_reader param
        param
      end
  end

  config_param :to, :body, :transport, :headers, :cc, :bcc,
              :html_body, :subject, :charset, :text_part_charset, :from,
              :attachments, :message_id, :sender, :reply_to, :via,
              :via_options

  def initialize(options)
    ConfigurationValidator.config_params.each do |param|
      instance_variable_set "@#{param}", options.delete(param)
    end
    raise InvalidParameterError.new(options) if options.any?
  end

end


class InvalidParameterError < StandardError
  def initialize(leftovers)
    @leftovers = leftovers
  end
  def message
    "You specified invalid options: #{@leftovers.keys.join(", ")}"
  end
end
