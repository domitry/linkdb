require 'net/http'
require 'mikon'

module Linkdb
  def fetch(*names)
    url = URI.parse()
    res = Net::HTTP.start() do |http|
      sub = "/link/genes/" + names.join("+")
      http.get(sub)
    end
    puts res.body
  end
end
