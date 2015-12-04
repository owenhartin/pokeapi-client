require "rest-client"

puts RestClient.get('http://pokeapi.co/api/v1/sprite/1/')
