class HomeController < ApplicationController
  def index
    if params[:zip].nil?
       @chapters = Chapter.order("state ASC").all
       @chapters_by_state = @chapters.group_by { |t| t.state }
    else
       @chapters = Chapter.near(params[:zip],params[:distance] || 50)
    end
     @json = @chapters.to_gmaps4rails do |chapter, marker|
        marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
#        marker.picture({
#                  :picture => "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|FE7569",
#                  :width   => 21,
#                  :height  => 43
#                 })
        marker.title   "#{chapter.name}"
        marker.json({ :id => chapter.id })
    end

    @circles_json = @chapters.map {|c| {:lat => c.latitude, :lng => c.longitude, :radius => c.radius || 100000 }}.to_json

  end

  def embed
    if params[:zip].nil?
       @chapters = Chapter.all
    else
        @chapters = Chapter.near(params[:zip],params[:distance] || 50)
    end
     @json = @chapters.to_gmaps4rails do |chapter, marker|
        marker.infowindow render_to_string(:partial => "/chapters/infowindow", :locals => { :chapter => chapter})
  #     marker.picture({
  #                  :picture => "http://www.blankdots.com/img/github-32x32.png",
  #                  :width   => 32,
  #                  :height  => 32
  #                 })
        marker.title   "#{chapter.name}"
        marker.json({ :id => chapter.id})

    end

    render :layout => 'embed'    

  end

end
