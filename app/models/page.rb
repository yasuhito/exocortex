require "rubygems"
require "redcloth"


class Page
  attr_reader :wiki_name
  attr_reader :content


  #
  # Page.new( "Hello+World", "h1. Hello" )
  #
  def initialize wiki_name, content = nil
    @wiki_name = wiki_name
    @content = content.gsub( /\r\n/, "\n" )
  end


  def name
    Syntax.page_name_from @wiki_name
  end


  def <=> other
    name <=> other.name
  end


  def == other
    ( name == other.name ) && ( content.chomp == other.content.chomp )
  end


  def to_html
    red_cloth = RedCloth.new( content )
    red_cloth.no_span_caps = true
    red_cloth.to_html.gsub( /\[\[(.*)\]\]/ ) do
      "[[" + Syntax.wiki_name_from( $1 ) + "]]"
    end
  end
end
