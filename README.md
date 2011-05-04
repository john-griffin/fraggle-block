# Fraggle::Block

A synchronous Ruby client for [Doozer](https://github.com/ha/doozer). 


## Usage

    >> require 'rubygems'
    >> require 'fraggle/block'
    >> client = Fraggle::Block.connect
    => #<Fraggle::Block::Client:0x10217b260 @connection=#<Fraggle::Block::Connection:0x10217bbc0 @cn=#<TCPSocket:0x10217b3c8>, host"127.0.0.1", port8046
    >> res = client.set(1_000_000, '/foo', 'test')
    => Fraggle::Block::Response tag: 0, flags: 3, rev: 482
    >> res = client.get(res.rev, '/foo')
    => Fraggle::Block::Response value: "test", tag: 0, flags: 3, rev: 482
    >> res = client.del(res.rev, '/foo')
    => Fraggle::Block::Response tag: 0, flags: 3
    >> client.disconnect
    => nil 

See [examples](https://github.com/dylanegan/fraggle-block/tree/master/examples) for more.


## Install

    $ gem install fraggle-block
