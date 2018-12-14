require "securerandom"
require "lazier/task_status"

module Lazier

  class BasicTask
    attr_reader :name
    attr_reader :result
    attr_reader :status
    attr_reader :error

    def initialize(name = "", &block)
      @status = TaskStatus::RUNNABLE
      @name = name || SecureRandom.hex(16)
      @todo = block
    end

    def todo(&block)
      @todo = block
    end

    def run(status)
      @status = TaskStatus::SKIPPED && return if @todo.nil?

      @status = TaskStatus::RUNNING

      # Do task
      @result = @todo.call(status)

      @status = TaskStatus::FINISHED
    end

    def running?
      @status == TaskStatus::RUNNING
    end

    def to_s
      str = @name

      case @status
        when TaskStatus::NONE then
          str += " NONE"
        when TaskStatus::RUNNABLE then
          str += " RUNNABLE"
        when TaskStatus::RUNNING then
          str += " RUNNING"
        when TaskStatus::PAUSE then
          str += " PAUSE"
        when TaskStatus::FINISHED then
          str += " FINISHED"
        when TaskStatus::SKIPPED then
          str += " SKIPPED"
        when TaskStatus::ERROR then
          str += " ERROR"
        else
          str += " UNKNOWN"
      end

      str
    end
  end

  class ConditionalTask < Task
    def when(&block)
      @when = block
    end

    def run(status, last_task)
      if @when.call(status, last_task)
        super(status)
      else
        @status = TaskStatus::SKIPPED
      end
    end
  end
end
