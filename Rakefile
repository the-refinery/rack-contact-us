desc "Run tests"
task :test => [:rspec, :cucumber]
task :default => [:test]

task :rspec do
  sh 'rspec spec'
end

task :cucumber do
  sh 'cucumber'
end
