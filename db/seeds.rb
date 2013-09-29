# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all

Product.create(:title => 'Programming Ruby 1.9',
	:description =>
		%{<p>
			Ruby is the fastest growing an dmost exciting dynamic lanugage out there. If you need to get working programs deliverd fast, yo should add Ruby to your toolbox.
		</p>},
	:image_url => '/images/ruby.png',
	:price => 49.50)
#...

Product.create(:title => 'MVQ book',
	:description =>
		%{<p>
				Maryanna is the greatest
		</p>},
	:image_url => '/images/mvq.png',
	:price => 100.50)
#...
#...