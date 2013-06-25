module ChaptersHelper
	def format_EIN(ein)
	 	"#{ein.chars.to_a[0..1].join}-#{ein.chars.to_a[2..8].join}" unless ein.nil? || ein.length == 0 || ein.length > 9 
	end
end
