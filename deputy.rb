require 'nokogiri'
require 'open-uri'
 
def get_email_adress(adrss)
	@email = []
	@dir_mail = []
	doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/#{adrss}"))
	doc.xpath("//a[@class='email']/@href").each do |node|
	@email << node.text[7..-1]
	end
	@dir_mail << @email.first
end

def get_url_of_each_deputy
	doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	doc.xpath("//div[@id='deputes-list']//a/@href").each do |node|
	@a << node
end
end

def get_name
	@name = []
	@first_name = []
	@family_name = []
	doc = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	doc.xpath("//div[@id='deputes-list']//a").each do |node|
	@name << node.text
end
	@name.compact.each do |x| @first_name << x.split[1]
	end
	@name.compact.each do |x| @family_name << x.split[2..-1]
	end
end

def perform
@a = []
get_name
get_url_of_each_deputy
@a.each do |x| get_email_adress(x)
end
end

def hasha
perform
reshash = {}
@name.zip(@dir_mail) { |k, v| reshash[k] = v}
puts reshash
end
	
hasha
