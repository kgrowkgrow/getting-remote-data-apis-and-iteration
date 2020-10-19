require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  response_string = RestClient.get('http://swapi.dev/api/people')
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  film_array_of_hashes = []
  response_hash["results"].each do |character_hash|
    if character_hash["name"].downcase == character_name
      film_array = character_hash["films"]
       film_array.each do |film|
        film_response_string = RestClient.get(film)
        film_response_hash = JSON.parse(film_response_string)
        film_array_of_hashes << film_response_hash        
      end
    end
  end 
  film_array_of_hashes 
end




def print_movies(films)
  films.each do |film|
    puts "*" * 30
    puts film["title"]
    puts "*" * 30
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
