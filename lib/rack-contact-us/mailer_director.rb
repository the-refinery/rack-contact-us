require_relative './utils/injector'

module ContactUs
  class MailerDirector
    def workflow
      [ConfigurationReader,
       ParameterRenderer,
       PonyTranslator,
       MailSender ]
    end
    def call(config, context)
      workflow.reduce({}) do |acc,step|
        params_context = { configuration_string: config, context: context, params: acc }
        injector = Utils::Injector.wrap step.new, :call, params_context
        injector.call
      end
    end
  end
end
