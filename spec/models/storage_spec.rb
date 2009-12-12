require "spec_helper"


describe Storage do
  before :each do
    @storage = Storage.new
  end


  it "should save pages in the format separated with ^L" do
    data_file = tempfile( "" )
    Storage.new( data_file.path ).save Page.new( "Superman", "His name is Clark Kent." )
    Storage.new( data_file.path ).save Page.new( "Hulk", "A giant green-skinned creature." )
    IO.read( data_file.path ).should == <<-EOF
Hulk
A giant green-skinned creature.

Superman
His name is Clark Kent.

EOF
  end


  it "should load a page" do
    data_file = tempfile( <<-EOF )
Superman
His name is Clark Kent.

EOF
    page = Storage.new( data_file.path ).load( "Superman" )
    page.name.should == "Superman"
    page.content.should == "His name is Clark Kent."
  end


  it "should return nil if failed to load a page" do
    Storage.new( tempfile( "" ).path ).load( "ShimuraKen" ).should be_nil
  end


  it "should return if a page exists or not" do
    data_file = tempfile( <<-EOF )
Superman
His name is Clark Kent.

EOF
    storage = Storage.new( data_file.path )

    storage.exists?( "Superman" ).should be_true
    storage.exists?( "Hulk" ).should be_false
  end
end
