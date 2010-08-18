require 'spec_helper'

describe "LayoutLinks" do
	it "should have a home page at '/'" do
		get '/'
		response.should render_template('pages/home')
	end
	
	it "should have an about page at '/about'" do
		get '/about'
		response.should render_template('pages/about')
	end
end
