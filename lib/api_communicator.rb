require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  response_string = RestClient.get('https://swapi.dev/api/people/')
  response_hash = JSON.parse(response_string)

  target_character = response_hash["results"].find { |character| character["name"].downcase == character_name} 

  get_movies_info(target_character)
end

def get_movies_info(character)
  character_movies = []

  character["films"].each do |movie_url|
    response_string = RestClient.get(movie_url)
    response_hash = JSON.parse(response_string)
    character_movies.push(response_hash)
  end
  character_movies
end

def print_movies(films)
  films.each.with_index(1) do |data, index|
    puts "#{index} " + data['title']
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end