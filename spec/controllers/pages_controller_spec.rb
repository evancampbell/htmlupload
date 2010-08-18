require 'spec_helper'

describe PagesController do
  integrate_views
  
  before(:each) do
    @base_title="ShareML"
  end
  
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'display'" do
    it "should be successful" do
      get 'display'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'about'
      response.should have_tag("title",@base_title+" | About")
    end
  end
end
