# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end

task :start do
  ruby 'bin/oniron'
end

task default: :test
