class Wiki
  def all_pages
    all_wiki_names = Storage.new.all_pages.keys
    all_wiki_names.sort.collect do | each, content |
      Page.load each
    end
  end


  def pages_link_to page
    all_pages.select do | each |
      each.content =~ /\[\[#{ Regexp.escape page.name }\]\]/
    end
  end
end
