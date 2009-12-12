require "redcloth"


class Page
  attr_reader :wiki_name


  #
  # Page.create( "Hello+World", "h1. Hello" )
  #
  def self.create wiki_name, content
    page = self.new( wiki_name )
    page.save content
  end


  #
  # Page.load( "Hello+World" )
  #
  def self.load wiki_name
    self.new wiki_name
  end


  def initialize wiki_name
    @wiki_name = wiki_name
    @storage = Storage.new
  end


  def save content
    @storage.save @wiki_name, content
    self
  end


  def <=> other
    name <=> other.name
  end


  def name
    @wiki_name.gsub( /\++/, " " )
  end


  def html
    red_cloth = RedCloth.new( content )
    red_cloth.no_span_caps = true
    red_cloth.to_html.gsub( /\[\[(.*)\]\]/ ) { "[[#{ $1.gsub( /\s/, "+" ) }]]" }
  end


  def exists?
    @storage.exists? wiki_name
  end


  def content
    @storage.load wiki_name
  end
end
