# Robbie

[Rovi](http://developer.rovicorp.com/Get_Started) API wrapper

## Installation

Add this line to your application's Gemfile:
```ruby
gem "robbie"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install robbie
```

## Usage

Working with models
```ruby
require "robbie"
Robbie.setup(api_key: "your api key", api_secret: "your api secret")

foo = Robbie::Artist.find_by_name("foo fighters")
# <Robbie::Artist:0x007fb9cbd7c120
#   @id="MN0000184043",
#   @name="Foo Fighters",
#   @is_group=true,
#   @genres=[#<Robbie::Genre:0x007fb9cbd7c2b0 @id="MA0000002613", @name="Pop/Rock">]
# >

# ...or directly by id
foo = Robbie::Artist.find("MN0000184043")

foo.albums.last
# <Robbie::Album:0x007fb9cc16b790 @id="MW0002115022", @title="Wasting Light">

# ...or directly by id
Robbie::Album.find("MW0002115022")

foo.albums.last.tracks.first
# <Robbie::Track:0x007fa633a39540
#   @id="MT0041016087",
#   @disc_id=1,
#   @position=1,
#   @artists=[#<Robbie::Artist:0x007fa633a397e8 @id="MN0000184043", @name="Foo Fighters">],
#   @title="Bridge Burning",
#   @duration=286
# >

# ...or directly by id
Robbie::Track.find("MT0041016087")
```

Autocomplete and extended autocomplete
```ruby
Robbie::Autocomplete.complete("b")
# ["Beyoncé", "Bruno Mars", "Bad Meets Evil", "Bon Iver", "Bob Marley",
#  "Big Sean", "The Band Perry", "Blake Shelton", "B.O.B", "The Black Eyed Peas"]

Robbie::Autocomplete.predict("b").first
# <Robbie::Artist:0x007fa633b31ba0
#   @id="MN0000761179",
#   @name="Beyoncé",
#   @is_group=false,
#   @genres=[#<Robbie::Genre:0x007fa633b31e48 @id="MA0000002809", @name="R&B">]
# >
```

You can turn response caching
```ruby
# on
Robbie.enable_cache
# and off
Robbie.disable_cache
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
