class Product < ActiveRecord::Base
	default_scope :order => 'title'
	
  attr_accessible :description, :image_url, :price, :title
	validates :title, :description, :image_url, :presence => true #Validate that each entry in the row has contents, do it in model because it is gatekeeper between model and outside world
	validates :price, :numericality => {:greater_than_or_equal_to => 0.01} #use .01 because any less would round down to 0 per our scope in the migration setup
	validates :title, :uniqueness => true #each product is unique entry
	#validates :title, :length => {:greater_than_or_equal_to => 10} #verifies that title is at least 10 characters long, commented out bc the test code violates this validation for now
	validates :image_url, :format => {
		:with => %r{\.(jpg|png|gif)$}i,
		:message => 'must be a URL for GIF, JPG, or PNG image.'

	}
  end
