class HomeController < ApplicationController
  def index
	if params[:zip].nil?
     @chapters = Chapter.all
    else
      @chapters = Chapter.near(params[:zip],params[:distance] || 20)
    end
	@json = @chapters.to_gmaps4rails do |chapter, marker|
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
