require 'spec_helper'


describe WikiController do
  before :each do
    data_file = tempfile( "" )
    @storage = Storage.new( data_file.path )
    Storage.stub!( :new ).and_return( @storage )
  end


  context "GET view/:id" do
    it "should display a page specified with the :id" do
      @storage.save Page.new( "Superman", "His name is Clark Kent." )
      get "view", :id => "Superman"
      response.should be_success
    end
  end


  context "GET search/:query" do
    it "should display a result page" do
      get "search", :query => "NoSuchPage"
      response.should be_success
    end


    it "should redirect to the found page" do
      @storage.save Page.new( "Superman", "His name is Clark Kent." )
      get "search", :query => "Superman"
      response.should redirect_to( :action => :view, :id => "Superman" )
    end
  end


  context "GET all" do
    it "should display all pages" do
      @storage.save superman_page
      get "all"
      response.should be_success
      assigns[ :all_pages ].size.should == 1
      assigns[ :all_pages ].first.should == superman_page
    end
  end


  context "GET create/:id" do
    it "should show edit page" do
      get "create", :id => "Superman"
      response.should redirect_to( :action => :edit, :id => "Superman" )
    end
  end


  context "GET edit/:id" do
    it "should show edit page" do
      get "edit", :id => "Superman"
      response.should be_success
    end
  end


  context "GET save/:id:content" do
    it "should save a page and view it" do
      @storage.should_receive( :save ).with( instance_of( Page ) )
      get "save", :id => "NewPage", :content => "Content"
      response.should redirect_to( :action => :view, :id => "NewPage" )
    end
  end


  def superman_page
    Page.new "Superman", "His name is Clark Kent."
  end
end
