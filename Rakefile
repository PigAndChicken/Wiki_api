require 'rake/testtask'

task :default do
  puts `rake -T`
end

desc 'run tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end

desc 'delete cassette fixtures'
task :rmvcr do
  sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
    puts(ok ? 'Cassettes deleted' : 'No cassettes found')
  end
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