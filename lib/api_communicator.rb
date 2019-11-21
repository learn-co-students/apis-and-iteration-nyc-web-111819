require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  # binding.pry
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  user_input_hash = response_hash["results"].find {|result| result["name"].downcase == character}
  film_request = user_input_hash["films"].map do |film| RestClient.get(film) end
  films = film_request.map {|hash| JSON.parse(hash)}   
end

  # binding.pry


# binding.pry
def print_movies(films)
  title_array = films.map {|film| film["title"]}
  title_array.map do |title| puts title end  
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
