require 'test_helper'

#modified to add the assert_selects to check that the content of the index page matches the fixture we made (w/3 entries)
class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success #verifies that index is returned, basic pageload
	assert_select '#columns #side a', :minimum => 4 #verifies that there are four a elements in side columns (note # before name is for ID lookup, . is for class lookup, nothing is for element lookup)
	assert_select '#main .entry', 3  #verifies that there are three entries in the main part of the page (based on our fixture entries)
	assert_select 'h3', 'Programming Ruby 1.9' #verifies that the third heading is the title we specified
	assert_select '.price', /\$[,\d]+\.\d\d/  #verifies that the price is formatted correctly using a regular expression. $ followed by any number of [] commas or digists followed by a decimal and two digits
  
  end

end
