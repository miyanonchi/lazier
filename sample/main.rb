#!/bin/env ruby

# bundlerでパスを指定してインストールしているなら必要
require 'bundler/setup'

require 'lazier'

# 全体的な設定
Lazier::Base.configure do |config|
  # set some config
end

flow = Lazier::TaskFlow.new

task1 = Lazier::Task.new("task 1") do |state|
  print "task 1\n"
  state[:next] = true
end

flow.add(task1)

task2 = Lazier::ConditionalTask.new("task 2")

task2.when do|state, last_task|
  state[:next] == true
end

task2.todo do |state|
  print "task 2\n"
end

flow.add(task2, 1)

flow.start

puts flow.list
