class Movie < ActiveRecord::Base
   attr_accessible :title, :release_date, :rating, :description
end
