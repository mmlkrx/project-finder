module ApplicationHelper
  def avatar_url(user)  
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase 
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=40" # s=40 adjusts img size
  end

  def broadcast(channel, &block)
    message = {channel: channel, data: capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, message: message.to_json)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
