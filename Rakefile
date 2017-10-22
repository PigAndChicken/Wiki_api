require 'rake/testtask'

task :default do
  puts `rake -T`
end

desc 'run tests'
task :spec do
  sh 'ruby spec/wiki_spec_vcr.rb'
end

namespace :quality do
  desc 'run all quality checks'
  task all: [:rubocop, :reek, :flog]
  
  task :rubocop do
    sh 'rubocop'
  end

  task :reek do
    sh "reek lib/"
  end

  task :flog do
    sh "flog lib/"
  end
end