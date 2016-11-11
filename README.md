# The Blizzard Armory Ruby Gem

A Ruby interface to the Blizzard Armory API.

## Installation
    gem install armory

## Usage Examples

***Configuring***

```ruby
client = Armory::REST::Client.new do |config|
  config.api_key = "<api key from https://dev.battle.net/>"
  config.cache = Moneta.new   # Optional
  config.logging = Logger.new # Optional
end
```

*** Retrive Character***

```ruby
character = client.character('realm_name', 'character_name',
                  region: "US",
                  fields: "progression,talents,items,achievements,pvp,pets,mounts")

puts character.items.head.name
```

*** Retrive Guild***
```ruby
guild = client.guild('realm_name', 'guild_name')
                      region: "US",
                      fields: 'members')
puts guild.members.count
```

## Object Graph
![Entity-relationship diagram][erd]

[erd]: https://cdn.rawgit.com/dippysan/armory/master/etc/erd.svg "Entity-relationship diagram"

This entity-relationship diagram is generated programatically. If you add or
remove any objects, please regenerate the ERD with the following
command:

    bundle exec rake erd


## Thanks
I leaned heavily on the excellent [Twitter Ruby Gem][twitter] for the structure of this Gem.

[twitter]: https://github.com/sferik/twitter

## Copyright
Copyright (c) 2016 David Peterson
See [LICENSE][] for details.

[license]: LICENSE.md
