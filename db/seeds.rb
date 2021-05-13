# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

url = 'http://tmdb.lewagon.com/movie/top_rated'
movie_serialized = URI.open(url).read
movie = JSON.parse(movie_serialized)

count = 1
page = 1
movies = movie['results']
# pp movies[30]
# pp "https://image.tmdb.org/t/p/w500#{movies[count]['poster_path']}"

puts 'cleaning db'
Movie.destroy_all
List.destroy_all
Bookmark.destroy_all

puts 'loading 15 movies'
15.times do
  if movies[count] == nil
    page += 1
    movie['page'] = page
    movies = movie['results']
    movie = Movie.create!(
      title: movies[count]['title'].to_s,
      overview: movies[count]['overview'].to_s,
      poster_url: "https://image.tmdb.org/t/p/w500#{movies[count]['poster_path']}",
      rating: movies[count]['vote_average'].to_s
    )
    puts "#{movie.title} created!"
    count += 1
  else
    movie = Movie.create!(
      title: movies[count]['title'].to_s,
      overview: movies[count]['overview'].to_s,
      poster_url: "https://image.tmdb.org/t/p/w500#{movies[count]['poster_path']}",
      rating: movies[count]['vote_average'].to_s
    )
    puts "#{movie.title} created!"
    count += 1
  end
end

puts 'creating lists'
5.times do
  List.create!(
    name: Faker::Cannabis.health_benefit
  )
end

puts 'creating bookmarks!'
  Bookmark.create!(
    comment: 'wowza what a show',
    list_id: 13,
    movie_id: 216
  )

puts 'All done!'
