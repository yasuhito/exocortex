class Storage
  DEFAULT_PATH = File.join( RAILS_ROOT, "storage.txt" )


  def initialize path = DEFAULT_PATH
    @path = path
  end


  def save page
    pages = all_pages
    pages[ page.wiki_name ] = page
    write pages
  end


  def load wiki_name
    all_pages[ wiki_name ]
  end


  def exists? wiki_name
    not all_pages[ wiki_name ].nil?
  end


  def all_pages
    pages = {}
    parse_data.keys.each do | each |
      pages[ each ] = Page.new( each, parse_data[ each ].join( "\n" ) )
    end
    pages
  end


  ##############################################################################
  private
  ##############################################################################


  def parse_data
    pages = {}
    wiki_name = nil
    wiki_name_line = true
    IO.read( @path ).each_line do | each |
      if wiki_name_line
        wiki_name_line = nil
        wiki_name = each.chomp
        pages[ wiki_name ] = []
      elsif each.chomp == "\f"
        wiki_name_line = true 
      else
        pages[ wiki_name ] << each.chomp
      end
    end
    pages
  end


  def write pages
    File.open( @path, "w" ) do | f |
      pages.keys.sort.each do | wiki_name |
        f.puts wiki_name
        f.puts pages[ wiki_name ].content
        f.puts "\f"
      end
    end
  end
end
