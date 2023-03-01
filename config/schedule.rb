set :bundle_command, "/usr/local/bin/bundle exec"

every :day, at: '12am' do
  rake 'currency_rates:update_rates', :output => {:error => 'error.log', :standard => 'cron.log'}
end