require "spec_helper"


describe Page do
  it "should return its page name" do
    Page.new( "Hello+World", "h1. Hello" ).name.should == "Hello World"
  end


  it "should be converted to an html string" do
    page = Page.new( "Hello+World", <<-EOF )
h1. Hello Exocortex World

[[Introduction to Exocortex]]
EOF

    page.to_html.chomp.should == ( <<-EOF ).chomp
<h1>Hello Exocortex World</h1>
<p>[[Introduction+to+Exocortex]]</p>
EOF
  end
end
