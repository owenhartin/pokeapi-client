require "rest-client"
require "json"

# Gets data for a single pokemon (gastly) using its id (92)
# data = RestClient.get 'http://pokeapi.co/api/v1/pokemon/92/'
# read = JSON.parse(data)
# puts JSON.pretty_generate(read)
#
# # Gets the sprite information for a pokemon by its id
# data = RestClient.get 'http://pokeapi.co/api/v1/sprite/93/'
# read = JSON.parse(data)
# puts JSON.pretty_generate(read)
#
# # Gets the picture by its id and shows it
# data = RestClient.get 'http://pokeapi.co/media/img/92.png'
# File.open('pic.png', 'w') do |file|
#   file.puts(data)
# end
# `open pic.png`
#

@pokedex_service_uri = 'http://pokeapi.co/'

def get_pokedex()
  data = RestClient.get @pokedex_service_uri + 'api/v1/pokedex/1/'
  json = JSON.parse(data)
  json
end

def get_pokemon_data(path)
  data = RestClient.get @pokedex_service_uri + path
  json = JSON.parse(data)
  json
end

def get_pokemon_picture(pokemon_path)
  pokemon_data = get_pokemon_data(pokemon_path)

  sprite_list = pokemon_data["sprites"]
  first_sprite = sprite_list.first

  sprite_data = get_pokemon_data(first_sprite["resource_uri"])

  RestClient.get @pokedex_service_uri + sprite_data["image"]
end

def search_pokedex(pokedex_json, name_to_find)
  pokemon_list = pokedex_json["pokemon"]
  pokemon_list.find {|pokemon|
    pokemon["name"] == name_to_find
  }
end

def show_pic(picture_data)
  File.open('pic.png', 'w') do |file|
    file.puts(picture_data)
  end
  `open pic.png`
end

# Gets data for the whole pokedex through the internet from a web service.
pokedex_json = get_pokedex()
puts "Searching for pokemon picture..."
found = search_pokedex(pokedex_json, "gloom")
picture_data = get_pokemon_picture(found["resource_uri"])
show_pic(picture_data)
