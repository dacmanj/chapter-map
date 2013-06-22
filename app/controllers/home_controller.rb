class HomeController < ApplicationController
  def index
    @chapters = Chapter.all
	@json = Chapter.all.to_gmaps4rails do |chapter, marker|
  		marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
#  		marker.picture({
#                  :picture => "http://www.blankdots.com/img/github-32x32.png",
#                  :width   => 32,
#                  :height  => 32
#                 })
  		marker.title   "i'm the title"
  		marker.sidebar "i'm the sidebar"
  		marker.json({ :id => chapter.id, :foo => "bar" })
	end
  end
end
