if ENV["RAILS_ENV"] == "production"
  ENV["FAYE_URL"] = "sleepy-reaches-9185.herokuapp.com"
else
  ENV["FAYE_URL"] = "localhost"
end