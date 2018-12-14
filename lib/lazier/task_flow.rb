require "logger"
require "lazier/task"

module Lazier
  class TaskFlow
    # this class has some tasks
    # and controls the state/flow of tasks.

    attr_reader :config
    attr_reader :tasks
    attr_reader :current_task_index

    attr_accessor :state

    def initialize(logger = nil)
      @logger = logger || Logger.new(STDOUT)

      @config = Lazier::Base.configuration
      @state = Hash.new
      @tasks = Array.new
      @current_task_index = 0
    end

    def add(task, index = 0)
      raise TypeError unless task.kind_of?(Lazier::Task)

      @tasks.insert(index, task)
    end

    def remove(task)
      if task.class == Integer
        @tasks.delete_at(task)
      elsif task.kind_of?(Lazier::Task)
        @tasks.delete(task)
      else
        raise TypeError
      end
    end

    def start
      last_task = nil
      @tasks.each do |t|
        case t
        when Lazier::ConditionalTask then
          t.run(@state, last_task)
        else
          t.run(@state)
        end

        last_task = t
      end
    end

    def next

    end

    def list
      @logger.info "[tasks]"
      @tasks.each.with_index do |t, i|
        @logger.info t.to_s
      end
    end

    def current_task
      @tasks[@current_task_index]
    end

    #def running?
    #  @tasks[@current_task_index].running?
    #end

    #def finished?
    #  !@tasks.last.running?
    #end
  end
end
