module WikiHelper
  def page_title name
    %{<h1 id="pageName">#{ name }</h1>}
  end


  def make_interlinks html, storage
    html.gsub( /\[\[(.*)\]\]/ ) do
      referred_wiki_name = $1
      referred_page_name = Syntax.page_name_from( $1 )
      if storage.exists?( referred_wiki_name )
        link_to referred_page_name, :controller => "wiki", :action => "view", :id => referred_wiki_name
      else
        referred_page_name + link_to( "?", :controller => "wiki", :action => "create", :id => referred_wiki_name )
      end
    end
  end


  def navi_home
    link_to( "Home Page", { :controller => "wiki", :action => "view", :id => "Home+Page" }, :accesskey => "H" )
  end


  def navi_all
    link_to( "All Pages", { :controller => "wiki", :action => "all" }, :accesskey => "A" )
  end
end
