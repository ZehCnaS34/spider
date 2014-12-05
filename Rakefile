require "bundler/gem_tasks"

task :default do
  puts "building"
  `gem build spider.gemspec`
  puts "installing"
  `gem install spider-*.gem`
end
