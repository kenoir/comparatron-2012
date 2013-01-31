module GetXPathNodesFromTheWeb 
	require 'nokogiri'
	require 'open-uri'

	def getNodes(xpath)
		nodes = []
		@doc.xpath(xpath).each do |node|
			nodes << node
		end 

		nodes
	end

	def openURI(uri)
		@doc = Nokogiri::HTML(open(uri))
	end

end

class Comparatron
	include GetXPathNodesFromTheWeb
	attr_accessor :uri

	def initialize(uri)
		@uri = uri
		openURI(@uri)
	end

	def showTextValues(xpath)
		nodes = getNodes(xpath)
		nodes.each do |node|
			puts node.text
		end
	end

	def compareValues(firstNodeXPath, secondNodeXPath)
		firstvalue = getNodes(firstNodeXPath).first.text.to_i
		secondValue = getNodes(secondNodeXPath).first.text.to_i
		
		firstvalue > secondValue
	end
end

def shout(thing)
	if(thing == true)
		puts "True!"
	else
		puts "False!"
	end
end

url = "http://www.londonelects.org.uk/im-voter/results-and-past-elections/live-results-2012?contest=23"
comparatron = Comparatron.new(url);
shout( comparatron.compareValues(
		'//*[@id="content"]/div[1]/table/tbody/tr[1]/td[2]/span',
		'//*[@id="content"]/div[1]/table/tbody/tr[2]/td[2]/span'))
