class Wiki
  def all_pages
    Storage.all.sort.collect do | each, content |
      Page.load each
    end
  end


  def pages_link_to page
    all_pages.select do | each |
      each.content =~ /\[\[#{ Regexp.escape page.name }\]\]/
    end
  end
end
