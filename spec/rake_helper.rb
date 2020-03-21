# frozen_string_literal: true

ENV['RAILS_ENV'] = 'production'

module Rake
  class Task
    def invoke(*args)
      # NOOP
    end

    def name
      'task_name'
    end
  end
end
