if ENV["RAILS_ENV"] == "production"
  ENV["FAYE_URL"] = "http://sleepy-reaches-9185.herokuapp.com:9292/faye"
else
  ENV["FAYE_URL"] = "http://localhost:9292/faye"
end