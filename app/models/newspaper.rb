class Newspaper < ActiveRecord::Base
  attr_accessible :category, :description, :link, :pubDate, :publisher, :title
end
