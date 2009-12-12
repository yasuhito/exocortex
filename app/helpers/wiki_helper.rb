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
      referred_wiki_name = $1
      if Storage.new.exists?( referred_wiki_name )
        link_to referred_wiki_name.gsub( "+", " " ), :action => "view", :id => referred_wiki_name
      else
        referred_wiki_name.gsub( "+", " " ) + link_to( "?", :action => "create", :id => referred_wiki_name )
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
