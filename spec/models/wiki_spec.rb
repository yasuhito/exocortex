require "spec_helper"


describe Wiki do
  before :each do
    @data_file = tempfile( "" )
    @wiki = Wiki.new( @data_file.path )
  end


  it "should return all pages" do
    save superman_page
    save hulk_page

    all_pages = @wiki.all_pages.sort
    all_pages[ 0 ].should == hulk_page
    all_pages[ 1 ].should == superman_page
  end


  it "should return all pages linking to a page" do
    save superman_page
    save hulk_page
    save dc_comics_page

    @wiki.all_pages_linking_to( superman_page ).size.should == 1
    @wiki.all_pages_linking_to( superman_page ).first.should == dc_comics_page

    @wiki.all_pages_linking_to( hulk_page ).size.should == 1
    @wiki.all_pages_linking_to( hulk_page ).first.should == dc_comics_page
  end


  def save page
    Storage.new( @data_file.path ).save page
  end


  def dc_comics_page
    Page.new "DC+Comics", <<-EOF
* [[Superman]]
* [[Hulk]]
EOF
  end


  def superman_page
    Page.new "Superman", "His name is Clark Kent."
  end


  def hulk_page
    Page.new "Hulk", "A giant green-skinned creature."
  end
end
