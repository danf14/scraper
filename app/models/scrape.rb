class Scrape

	attr_accessor :title, :hotness, :image_url, :rating, :director, :genre, :release_date, :runtime, :synopsis, :failure

	def scrape_new_movie
		begin 
			doc = Nokogiri::HTML(open("https://www.rottentomatoes.com/m/the_martian"))

			doc.css('script').remove

			self.title = doc.at("//h1[@data-type = 'title']").text
			self.hotness = doc.at("//span[@class = 'superPageFontColor']").text.to_i
			self.image_url = doc.at_css('img.posterImage')['src']
			self.rating = doc.css('.info div:nth-child(2)').text
			self.genre = doc.css('.info div:nth-child(4)').text
			self.director = doc.css('.info div:nth-child(6)').text
			self.release_date = doc.css('.info div:nth-child(10)').text.to_date
			self.runtime = doc.css('.info div:nth-child(14)').text
			self.synopsis = doc.css('.panel-body.content_body').text
			return true
		rescue Exception => e
			self.failure = "Something went wrong"
		end

	end

end