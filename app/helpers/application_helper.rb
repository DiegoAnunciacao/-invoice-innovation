module ApplicationHelper
  def provider_name(provider)
    case provider
    when :google_oauth2
      "Google"
    when :facebook
      "Facebook"
    else
      provider.to_s.titleize
    end
  end
end
