require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  fixtures :products #set which fixture you would like to load, this empties exisitng and  pulls in products.yml
  
  #test by creating an empty product and verifying that the fields all have errors
  test "product attributes must not be empty" do
	product = Product.new
	assert product.invalid?
	assert product.errors[:title].any?
	assert product.errors[:description].any?
	assert product.errors[:price].any?
	assert product.errors[:image_url].any?
  end
  
  test "product price must be positive" do
	product =  Product.new(:title       => "My Book title",
							:description => "yyy",
							:image_url => "zzz.jpg")
	product.price = -1
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01",
		product.errors[:price].join('; ')
		
	product.price = 0
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01",
		product.errors[:price].join('; ')
	
	product.price = 1
	assert product.valid?
  end
  #this method creates a new product with the image url that you provide

  def new_product(image_url)
	Product.new(:title       => "My Book title",
				:description => "yyyy",
				:price     	 => 1, 
				:image_url	 => image_url)
  end
	
	#check different image file name types and cycle through list to ensure validation is working properly
	test "image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
				http://a.b.c/x/y/z/fred.gif }
		bad = %w{ fred.doc fred.gift/more fred.gif.more}
		
		ok.each do |name|
			assert new_product(name).valid?, "#{name} shouldn't be invalid"
		end
		
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end
	
	#this test reads in the title from a book already in the list from the yaml products database in config for testing and asserts that it shouldn't save due to the unique validation
	test "product is not valid without a unique title" do
		product= Product.new(:title 		=> products(:ruby).title,
							 :description 	=> "yyy",
							 :price 		=> 1,
							 :image_url 	=> "fred.gif")
		assert !product.save
		#use the code below to compare the response against the built in message table rather than a hard coded message
		assert_equal I18n.translate('activerecord.errors.messages.taken'),
								product.errors[:title].join('; ')
	end

end




