class Wiki
  def initialize storage_path = nil
    @storage_path = storage_path
  end


  def all_pages
    ( @storage_path ? Storage.new( @storage_path ) : Storage.new ).all_pages.values
  end


  def all_pages_linking_to page
    all_pages.select do | each |
      each.content =~ /\[\[#{ Regexp.escape page.name }\]\]/
    end
  end
end
