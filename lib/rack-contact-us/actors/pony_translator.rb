module ContactUs
  class PonyTranslator
    def translate_via_config(config)
      is_smtp = config.key?(:smtp)
      is_sendmail = !is_smtp && config.key?(:sendmail)
      return {} unless is_smtp || is_sendmail
      key = if is_smtp then :smtp else :sendmail end
      { via: key, via_options: config.delete(key) }
    end

    def translate_body_config(config)
      { html_body: config.delete(:html_template), body: config.delete(:text_template) }
    end

    def call(params)
      params.dup.tap do |new_config|
        new_config.merge!(translate_via_config(new_config))
        new_config.merge!(translate_body_config(new_config))
      end
    end
  end
end
