# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Publisher.delete_all

Publisher.create(category: 'economics',
	link: 'http://imnews.imbc.com/rss/news/news_04.xml',
	name: 'imnews')
Publisher.create(category: 'politics',
	link: 'http://www.chosun.com/site/data/rss/politics.xml',
	name: '조선일보')
Publisher.create(category: 'society',
	link: 'http://www.chosun.com/site/data/rss/national.xml',
	name: '조선일보')
Publisher.create(category: 'international',
	link: 'http://www.chosun.com/site/data/rss/international.xml',
	name: '조선일보')
Publisher.create(category: 'culture',
	link: 'http://www.chosun.com/site/data/rss/sports.xml',
	name: '조선일보')

