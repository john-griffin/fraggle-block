$:.unshift File.dirname(__FILE__) + '/../lib'
require 'rubygems'
require 'fraggle/block'

client = Fraggle::Block.connect

rev = client.set(1_000_000, '/foo', 'test').rev
puts "Setting /foo to test with rev #{rev}"

foo = client.get(rev, '/foo')
puts "Got /foo with #{foo.value}"

rev = client.del(rev, '/foo').rev
puts "Deleted /foo"

foo = client.get(rev, '/foo')
puts foo.inspect

client.disconnect
