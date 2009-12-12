class WikiController < ApplicationController
  def initialize
    @wiki = Wiki.new
  end


  def view
    @storage = Storage.new
    @page = Storage.new.load( params[ :id ] )
    @title = @page.name
    @linked_from_list = @wiki.all_pages_linking_to( @page )
  end


  def search
    @query = params[ "query" ]
    @title_results = @wiki.all_pages.select { | each | each.name =~ /#{ @query }/i }.sort
    @results = @wiki.all_pages.select { | each | each.content =~ /#{ @query }/i }.sort
    all_pages_found = ( @results + @title_results ).uniq
    if all_pages_found.size == 1
      redirect_to :action => :view, :id => all_pages_found.first.wiki_name
    end
  end


  def all
    @all_pages = @wiki.all_pages
  end


  def create
    redirect_to :action => :edit, :id => params[ :id ]
  end


  def edit
    @page = Storage.new.load( params[ :id ] ) || Page.new( params[ :id ], "" )
  end


  def save
    page = Page.new( params[ :id ], params[ :content ] )
    Storage.new.save page
    redirect_to :action => :view, :id => page.wiki_name
  end
end
