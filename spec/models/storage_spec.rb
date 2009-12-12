require "spec_helper"


describe Storage do
  before :each do
    @storage = Storage.new
  end


  it "should save pages in the format separated with ^L" do
    data_file = tempfile( "" )
    Storage.new( data_file.path ).save "Superman", "His name is Clark Kent."
    Storage.new( data_file.path ).save "Hulk", "A giant green-skinned creature."
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
    Storage.new( data_file.path ).load( "Superman" ).should == "His name is Clark Kent."
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


  def tempfile content
    t = Tempfile.new( "storage" )
    t.print content
    t.flush
    t
  end
end
