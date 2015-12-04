require "rest-client"
require "json"

data = RestClient.get 'http://pokeapi.co/api/v1/pokedex/1/'
read = JSON.parse(data)
puts JSON.pretty_generate(read)

data = RestClient.get 'http://pokeapi.co/api/v1/pokemon/92/'
read = JSON.parse(data)
puts JSON.pretty_generate(read)

data = RestClient.get 'http://pokeapi.co/api/v1/sprite/93/'
read = JSON.parse(data)
puts JSON.pretty_generate(read)

data = RestClient.get 'http://pokeapi.co/media/img/92.png'
File.open('pic.png', 'w') do |file|
  file.puts(data)
end
`open pic.png`
