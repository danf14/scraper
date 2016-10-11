class Scrape

		attr_accessor :title, :hotness, :image_url, :rating, :director, :genre, :release_date, :runtime, :synopsis, :failure

		def scrape_new_movie(url)
			begin 
				doc = Nokogiri::HTML(open(url))

				doc.css('script').remove

				self.title = doc.at("//h1[@data-type = 'title']").text.strip
				self.hotness = doc.at("//span[@class = 'superPageFontColor']").text.to_i
				self.image_url = doc.at_css('img.posterImage')['src']
				self.rating = doc.css('.info div:nth-child(2)').text.strip.strip
				self.genre = doc.css('.info div:nth-child(4)').text.strip
				self.director = doc.css('.info div:nth-child(6)').text.strip
				self.release_date = doc.css('.info div:nth-child(10)').text.to_date
				self.runtime = doc.css('.info div:nth-child(14)').text.strip
				self.synopsis = doc.css('#movieSynopsis').text.tidy_bytes.strip

				return true

			rescue Exception => e
				self.failure = "Something went wrong"
			end

		end

end