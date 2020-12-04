desc 'Lint files'
task 'lint' => :environment do
    sh 'rubocop'
end