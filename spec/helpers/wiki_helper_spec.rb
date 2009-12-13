require 'spec_helper'

describe WikiHelper do
  helper_name :wiki


  it "should show page title" do
    helper.page_title( "PAGE_NAME" ).should == %{<h1 id="pageName">PAGE_NAME</h1>}
  end


  it "should make interlinks between pages" do
    data_file = tempfile( "" )
    storage = Storage.new( data_file.path )
    storage.save Page.new( "Superman", "His name is Clark Kent." )
    storage.save Page.new( "Hulk", "A giant green-skinned creature." )

    html = helper.make_interlinks( <<-HTML, storage )
[[Superman]]
[[Hulk]]
[[Shimura+Ken]]
HTML
    html.should == <<-EOF
<a href="/Superman">Superman</a>
<a href="/Hulk">Hulk</a>
Shimura Ken<a href="/wiki/create/Shimura+Ken">?</a>
EOF
  end


  it "should show navigation home" do
    helper.navi_home.should == %{<a href="/" accesskey="H">Home Page</a>}
  end


  it "should show navigation all" do
    helper.navi_all.should == %{<a href="/wiki/all" accesskey="A">All Pages</a>}
  end
end
