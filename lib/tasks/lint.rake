desc "Lint files"
task "lint" => :environment do
  sh "rubocop --format clang"
end