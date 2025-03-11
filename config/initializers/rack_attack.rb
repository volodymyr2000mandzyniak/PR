# config/initializers/rack_attack.rb

class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  throttle('req/ip', limit: 100, period: 1.minute) do |req|
    req.ip
  end

  throttle('projects/ip', limit: 50, period: 1.minute) do |req|
    if req.path == '/projects' && req.get?
      req.ip
    end
  end

  self.throttled_responder = lambda do |env|
    [429, { 'Content-Type' => 'application/json' }, [{ error: 'Rate limit exceeded. Please try again later.' }.to_json]]
  end
end