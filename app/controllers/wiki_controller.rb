class WikiController < ApplicationController
  def initialize
    @storage = Storage.new
    @wiki = Wiki.new
  end


  def view
    @page = @storage.load( params[ :id ] )
  end


  def search
    @query = params[ "query" ]
    @title_results = @wiki.all_pages.select { | each | each.name =~ /#{ @query }/i }.sort
    @results = @wiki.all_pages.select { | page | page.content =~ /#{ @query }/i }.sort
    all_pages_found = ( @results + @title_results ).uniq
    if all_pages_found.size == 1
      redirect_to :action => :view, :id => all_pages_found.first
    end
  end


  def all
    @all_pages = @wiki.all_pages
  end


  def create
    redirect_to :action => :edit, :id => params[ :id ]
  end


  def edit
    @page = @storage.load( params[ :id ] )
  end


  def save
    page = Page.new( params[ :id ], params[ :content ] )
    @storage.save page
    redirect_to :action => :view, :id => page.wiki_name
  end
end
