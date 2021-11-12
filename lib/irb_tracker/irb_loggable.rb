# frozen_string_literal: true

require 'irb_tracker/logger_factory'

module IRBTracker
  #:nodoc:
  class IRBLoggable < Module
    def initialize(service_name = 'undefined', file_name = 'console.log')
      logger = LoggerFactory.create service_name, file_name
      # rubocop:disable Style/RedundantBegin
      define_method :evaluate do |*args, &block|
        begin
          result = super(*args, &block)
          logger.info(source: 'irb_console',
                      user: LDAPLogin.current_user,
                      command: args.first.chomp,
                      result: inspect_last_value.chomp)
          result
        rescue StandardError => e
          logger.error(source: 'irb_console',
                       user: LDAPLogin.current_user,
                       command: args.first.chomp,
                       error: e.message,
                       error_trace: e.backtrace.inspect)
          raise e
        end
      end
      # rubocop:enable Style/RedundantBegin
    end
  end
end
