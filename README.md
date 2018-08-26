# doh_client

[![Build Status](https://travis-ci.org/ninoseki/doh_client.svg?branch=master)](https://travis-ci.org/ninoseki/doh_client)
[![Maintainability](https://api.codeclimate.com/v1/badges/e9119ee2021f1cfb895d/maintainability)](https://codeclimate.com/github/ninoseki/doh_client/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/doh_client/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/doh_client?branch=master)

DNS over HTTPS(DoH) client for Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doh_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doh_client

## Supported platforms

- [Google Public DNS](https://developers.google.com/speed/public-dns/docs/dns-over-https)
- [Cloudflare](https://developers.cloudflare.com/1.1.1.1/dns-over-https/)

## Usage

### As a Library

```rb
require 'doh_client'

DoHClient::Google.resolve("example.com", { type: "A" })
DoHClient::Google.resolve("example.com", { type: "A", edns_client_subnet: "0.0.0.0/0", random_padding: "XmkMw~o_mgP2pf.gpw-Oi5dK" })

DoHClient::Cloudflare.resolve("example.com", { type: "A" })
DoHClient::Cloudflare.resolve("example.com", { type: "A", do: true, cd: false })
```

### As a CLI

```bash
$ doh_client
Commands:
  console help [COMMAND]  # Describe available commands or one specific command
  console resolve [NAME]  # resolve a given name

Options:
  [--resolver=RESOLVER]  # a resolver to use ('google' or 'cloudflare', default: google)

$ doh_client resolve example.com --type A
# => {"Status":0,"TC":false,"RD":true,"RA":true,"AD":true,"CD":false,"Question":[{"name":"example.com.","type":1}],"Answer":[{"name":"example.com.","type":1,"TTL":5169,"data":"93.184.216.34"}]}
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
