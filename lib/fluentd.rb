# frozen_string_literal: true

require 'fluent-logger'

#:nodoc:
class Fluentd
  def self.get_logger(**options)
    service_name = options.delete(:service_name)
    logger = Fluent::Logger::LevelFluentLogger.new(
      service_name,
      host: options.delete(:host),
      port: options.delete(:port)
    )

    logger.formatter = build_formatter(service_name)
    logger
  end

  def self.build_formatter(service_name)
    proc do |severity, datetime, progname, message|
      map = { level: severity }
      map[:message] = message[:error] || message[:event] || message[:command]
      %i[error error_trace command result event name args source].each do |item|
        map[item] = message[item] if message[item] && !message[item].empty?
      end
      map[:progname] = progname if progname
      if datetime
        map['@timestamp'] = datetime.strftime('%Y-%m-%dT%H:%M:%S.%3NZ')
      end
      map[:environment] = ENV.fetch('FLUENTD_LOGGING_ENVIRONMENT', 'undefined')
      map[:service_name] = service_name
      map[:app_version] = ENV.fetch('APP_VERSION', 'undefined')
      map
    end
  end
  private_class_method :build_formatter
end
