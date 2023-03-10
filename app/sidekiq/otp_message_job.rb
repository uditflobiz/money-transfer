class OtpMessageJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: false

  def perform(message)
    response = HTTParty.post('https://slack.com/api/chat.postMessage', body: { "channel": "CQG1PRBUH", "text": message}.to_json, headers: { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{ENV['api_key']}"})
    raise CustomError.new("Slack API Error") if !response["ok"]
  end
end
