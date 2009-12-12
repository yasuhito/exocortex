class Syntax
  def self.page_name_from wiki_name
    wiki_name.gsub "+", " "
  end


  def self.wiki_name_from page_name
    page_name.gsub /\s/, "+"
  end
end
