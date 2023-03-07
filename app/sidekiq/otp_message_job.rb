class OtpMessageJob
  include Sidekiq::Job
  sidekiq_options queue: 'default', retry: false

  def perform(*args)
    puts("abc")
  end
end
