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

	def showTextValues
		nodes = getNodes("//h3/a")
		nodes.each do |node|
			puts node.text
		end
	end
end

comparatron = Comparatron.new("http://www.google.com/search?q=doughnuts");
comparatron.showTextValues
