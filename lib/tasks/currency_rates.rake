namespace :currency_rates do
  desc "updates currency rates"
  task update_rates: :environment do
    $redis.set("inr#usd", 0.01210)
    $redis.set("inr#eur", 0.01140)
    $redis.set("inr#gbp", 0.00999)
    $redis.set("inr#yen", 1.65713)
    $redis.set("usd#inr", 82.62915)
    $redis.set("usd#eur", 0.94166)
    $redis.set("usd#gbp", 0.82537)
    $redis.set("usd#yen", 136.86344)
    $redis.set("eur#inr", 87.709109)
    $redis.set("eur#usd", 1.06193)
    $redis.set("eur#gbp", 0.87632)
    $redis.set("eur#yen", 145.32501)
    $redis.set("gbp#inr", 100.08825)
    $redis.set("gbp#usd", 1.21172)
    $redis.set("gbp#eur", 1.14109)
    $redis.set("gbp#yen", 165.84452)
    $redis.set("yen#inr", 0.60350)
    $redis.set("yen#usd", 0.00730)
    $redis.set("yen#eur", 0.00688)
    $redis.set("yen#gbp", 0.00602)
  end
end
