require 'fraggle/block/connection'

module Fraggle
  module Block
    class Client
      include Request::Verb

      MaxInt64 = 1<<63 - 1

      class NoMoreAddrs < StandardError; end

      attr_accessor :addrs
      attr_reader :connection

      def initialize(addrs = [])
        @addrs = addrs
        connect
      end

      def rev
        send(:verb => REV)
      end

      def get(rev, path)
        send(:verb => GET, :rev => rev, :path => path)
      end

      def set(rev, path, value)
        send(:verb => SET, :rev => rev, :path => path, :value => value)
      end

      def del(rev, path)
        send(:verb => DEL, :rev => rev, :path => path)
      end

      def walk(rev, path, offset)
        send(:verb => WALK, :rev => rev, :path => path, :offset => offset)
      end

      def disconnect
        @connection.disconnect
      end

      def reconnect
        disconnect
        connect
      end

      def connect
        begin
          host, port = @addrs.shift.split(":")
          @connection = Connection.new(host, port)
          find_all_of_the_nodes
        rescue => e
          retry if @addrs.any?
          raise(NoMoreAddrs)
        end
      end

      def find_all_of_the_nodes
        r = rev.rev
        i = 0
        loop do
          res = walk(r, "/ctl/node/*/addr", i)
          if res.ok?
            i += 1
            @addrs << res.value if !(@addrs.include?(res.value))
          else
            break
          end
        end
      end

    protected

      def send(request)
        @connection.send(Request.new(request))
        @connection.read
      end
    end
  end
end
