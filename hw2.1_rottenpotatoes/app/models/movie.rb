class Movie < ActiveRecord::Base
  def self.getRatings
    Movie.find(:all, :select => "DISTINCT rating" ).collect{ |x| x[:rating]}
  end
end
