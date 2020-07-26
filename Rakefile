# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end

task :start do
  ruby 'bin/everscape'
end

RuboCop::RakeTask.new(:format) do |t|
  t.options = ['--fix-layout']
end

task default: :test
