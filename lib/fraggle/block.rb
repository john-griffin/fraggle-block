require "fraggle/block/client"
require "fraggle/block/response"

module Fraggle
  module Block
    Clobber = Client::MaxInt64

    DEFAULT_URI = "doozer:?" + [
      "ca=127.0.0.1:8046",
      "ca=127.0.0.1:8041",
      "ca=127.0.0.1:8042",
      "ca=127.0.0.1:8043"
    ].join("&")

    def self.connect(uri=nil)
      uri = uri || ENV["DOOZER_URI"] || DEFAULT_URI

      addrs = URI.parse(uri)

      if addrs.length == 0
        raise(ArgumentError, "no addrs in doozerd uri '#{uri.inspect}'")
      end

      Client.new(addrs)
    end

    module URI
      def self.parse(u)
        if u =~ /^doozer:\?(.*)$/
          parts = $1.split("&")
          parts.inject([]) do |m, pt|
            k, v = pt.split("=")
            if k == "ca"
              m << v
            end
            m
          end
        else
          raise(ArgumentError, "invalid doozerd uri '#{u}'")
        end
      end
    end
  end
end
