require 'net/http'
require 'mikon'
require 'tempfile'

module Linkdb
  def self.fetch(*names, **options)
    options = {
      headers: ["name", "type", "option"]
    }.merge(options)

    url = URI.parse("http://rest.genome.jp")
    res = Net::HTTP.start(url.host, url.port) do |http|
      sub = "/link/" + names.join("+")
      http.get(sub)
    end

    file = Tempfile.new("dataframe")
    file.write(res.body)
    file.close

    Mikon::DataFrame.from_csv(file.path, col_sep: " ", headers: options[:headers])
  end
end
