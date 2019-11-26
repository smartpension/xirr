require "bundler/gem_tasks"

require 'rake'
require 'rake/testtask'

require 'rake/extensiontask'

task :default => [:test_units]

Rake::TestTask.new("test_units") do |t|
  t.pattern = 'test/*.rb'
  t.verbose = false
  t.warning = false
end

Rake::ExtensionTask.new("xirr") do |ext|
  ext.lib_dir = "lib/xirr"
end
