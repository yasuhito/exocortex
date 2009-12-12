module WikiHelper
  def page_name name
    %{<h1 id="pageName">#{ name }</h1>}
  end


  def navigation_bar name
    %{<div class="navigation">} +
      ( name != "Home Page" ? navi_home + " | " : "" ) +
      ( name != "All Pages" ? link_to( "All Pages", { :action => "all" }, :accesskey => "A" ) + " | " : "" ) + 
      render( :file => 'search_form' ) +
    %{</div>}
  end


  def make_interlinks html
    html.gsub( /\[\[(.*)\]\]/ ) do
      referred = Page.load( $1 )
      if referred.exists?
        link_to referred.name, :action => "view", :id => $1
      else
        referred.name + link_to( "?", :action => "create", :id => $1 )
      end
    end
  end


  def navi_home
    link_to( "Home Page", { :action => "view", :id => "Home+Page" }, :accesskey => "H" )
  end


  def all_pages
    @wiki.all_pages
  end
end
