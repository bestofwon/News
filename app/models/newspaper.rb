class Newspaper < ActiveRecord::Base
  attr_accessible :category, :description, :link, :pubDate, :publisher, :title
  has_many :clips
end
