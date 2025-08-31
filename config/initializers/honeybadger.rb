Honeybadger.configure do |config|
    config.api_key = ENV['HONEYBADGER_API_KEY']
    config.env = Rails.env

    if Rails.env.development?
        config.development_environments = []
    end
end